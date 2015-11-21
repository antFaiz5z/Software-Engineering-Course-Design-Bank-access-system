package controller;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.Record;
import constant.Constant;
import interceptor.StaffAuthInterceptor;
import interceptor.StaffUserAuthInterceptor;
import service.StaffService;
import service.UserService;

import java.util.Date;
import java.util.Objects;

/**
 * Created by ·² on 2015/10/11.
 */
@Before(StaffAuthInterceptor.class)
public class StaffController extends Controller {

    @Clear
    public void index() {

        renderJsp("staff_login.jsp");
    }

    public void home() {

        renderJsp("staff_home.jsp");
    }

    @Before(StaffUserAuthInterceptor.class)
    public void manage() {

        renderJsp("staff_manage.jsp");
    }

    public void create() {

        renderJsp("staff_create_user.jsp");
    }

    @Clear
    public void success() {

        renderJsp("staff_success.jsp");
    }

    @Clear
    public void error() {

        renderJsp("staff_error.jsp");
    }

    @Clear
    public void login() {

        String staffid = getPara("staff_id");
        String password = getPara("staff_password");

        if (StaffService.login(staffid, password)) {

            setSessionAttr("staff_id", staffid);
            redirect("/staff/home?page=1");
        } else {

            redirect("/staff/error");
        }
    }

    public void logout() {

        removeSessionAttr("staff_id");
        redirect("/staff");

    }

    public void userLogin() {

        String userid = getPara("staff_user_id");
        String password = getPara("staff_user_password");

        if (UserService.login(userid, password)) {

            setSessionAttr("staff_user_id", userid);
            redirect("/staff/manage");
        } else {

            redirect("/staff/error");
        }
    }

    public void userLogout() {

        removeSessionAttr("staff_user_id");
        redirect("/staff/home");
    }


    public void createNewUser() {

        String name = getPara("user_name");
        String idcard = getPara("user_idcard");
        String password = getPara("user_password");
        String password_re = getPara("user_password_re");
        String type = getPara("user_type");
        String balance = getPara("user_balance");

        if ((type.equals("0") && Integer.parseInt(balance) < Constant.NORMAL_ACCOUNT_INITIAL_AMOUNT) || (type.equals("1") && Integer.parseInt(balance) < Constant.GOLD_ACCOUNT_INITIAL_AMOUNT)) {
            redirect("/staff/create");
        } else if (!password.equals(password_re)) {
            redirect("/staff/create");
        } else {

            UserService.saveNewUser(name, password, idcard, type, balance);
            redirect("/staff/home");
        }


    }

    @Before(StaffUserAuthInterceptor.class)
    public void cancelUser() {

        String userid = getSessionAttr("staff_user_id");
        Record user = UserService.getUserByID(userid);

        Integer password = getParaToInt("user_password");

        if (!Objects.equals(password, user.getInt(Constant.USER_PASSWORD))) {
            redirect("/staff/error");
        } else {
            UserService.deleteAllRecordById(userid);
            removeSessionAttr("staff_user_id");
            redirect("/staff/home");
        }

    }

    @Before(StaffUserAuthInterceptor.class)
    public void withdrawal() {

        double amount = Double.parseDouble(getPara("withdrawal_amount"));
        String userid = getSessionAttr("staff_user_id");
        Record user = UserService.getUserByID(userid);

        Long days = UserService.HowManyDaysFromLastSettle(user);

        UserService.isThereAnyFixedDepositsForThisUser(userid);

        double interest_add = UserService.settleInterestAddButNotAdd(user, days);

        if (user.getDouble(Constant.USER_BALANCE) + user.getDouble(Constant.USER_INTEREST) + interest_add < amount) {
            redirect("/staff/error");
        } else {

            Long now = new Date().getTime();

            UserService.settleInterestAddAndAmountToBalance(user, interest_add - amount, now);

            String history_id = UserService.saveNewHistory(userid, 0, amount, now);

            redirect("/staff/success?activity=withdrawal&history_id=" + history_id);

            //redirect("/staff/manage");
        }
    }

    @Before(StaffUserAuthInterceptor.class)
    public void currentDeposit() {

        double amount = Double.parseDouble(getPara("current_deposit_amount"));
        String userid = getSessionAttr("staff_user_id");
        Record user = UserService.getUserByID(userid);
        Long now = new Date().getTime();

        Long days = UserService.HowManyDaysFromLastSettle(user);

        UserService.isThereAnyFixedDepositsForThisUser(userid);

        double interest_add = UserService.settleInterestAddButNotAdd(user, days);

        UserService.settleInterestAddAndAmountToBalance(user, interest_add + amount, now);

        String history_id = UserService.saveNewHistory(userid, 1, amount, now);

        redirect("/staff/success?activity=currentDeposit&history_id=" + history_id);

        //redirect("/staff/manage");
    }

    @Before(StaffUserAuthInterceptor.class)
    public void fixedDeposit() {

        double amount = Double.parseDouble(getPara("fixed_deposit_amount"));
        int fixed_deposit_type = getParaToInt("fixed_deposit_type");
        String userid = getSessionAttr("staff_user_id");
        Record user = UserService.getUserByID(userid);

        Long days = UserService.HowManyDaysFromLastSettle(user);

        UserService.isThereAnyFixedDepositsForThisUser(userid);

        double interest_add = UserService.settleInterestAddButNotAdd(user, days);

        if (user.getDouble(Constant.USER_BALANCE) + user.getDouble(Constant.USER_INTEREST) + interest_add < amount) {
            redirect("/staff/error");
        } else {

            double income = 0;
            Long period = 0L;
            long now = new Date().getTime();

            if (user.getInt(Constant.USER_TYPE) == 0) {
                if (fixed_deposit_type == 0) {
                    period = 15768000000L;
                    income = amount * Constant.NORMAL_ACCOUNT_PERIODIC_RATE_OF_HALF_YEAR * 365 * 0.5;
                } else if (fixed_deposit_type == 1) {
                    period = 31536000000L;
                    income = amount * Constant.NORMAL_ACCOUNT_PERIODIC_RATE_OF_ONE_YEAR * 365;
                } else {
                    redirect("/staff/error");
                }
            } else if (user.getInt(Constant.USER_TYPE) == 1) {
                if (fixed_deposit_type == 1) {
                    period = 31536000000L;
                    income = amount * Constant.GOLD_ACCOUNT_PERIODIC_RATE_OF_ONE_YEAR * 365;
                } else {
                    redirect("/staff/error");
                }
            }

            if (period == 0 || income == 0)
                redirect("/staff/error");

            UserService.settleInterestAddAndAmountToBalance(user, interest_add - amount, now);

            String history_id = UserService.saveNewHistory(userid, 2, amount, now);

            Record deposit = new Record()
                    .set(Constant.USER_ID, userid)
                    .set(Constant.FD_TYPE, fixed_deposit_type)
                    .set(Constant.FD_START_DATE, now)
                    .set(Constant.FD_END_DATE, now + period)
                    .set(Constant.FD_AMOUNT, amount)
                    .set(Constant.FD_INCOME, income)
                    .set(Constant.FD_IS_VALID, 0);
            Db.save(Constant.TABLE_FIXED_DEPOSIT, Constant.FD_ID, deposit);
            String fd_id = deposit.get(Constant.FD_ID).toString();

            redirect("/staff/success?activity=fixedDeposit&history_id=" + history_id + "&fd_id=" + fd_id);

            //redirect("/staff/manage");

        }
    }
}
