package service;

import com.jfinal.plugin.activerecord.Db;
import com.jfinal.plugin.activerecord.DbPro;
import com.jfinal.plugin.activerecord.Record;
import constant.Constant;

import java.util.Date;
import java.util.List;

/**
 * Created by 凡 on 2015/10/13.
 */
public class UserService {

    public static boolean login(String userid, String password) {

        String sql = "select " + Constant.USER_ID + " from " + Constant.TABLE_USER + " where " +
                Constant.USER_ID + " = ? and " + Constant.USER_PASSWORD + " = ?";
        Integer result = DbPro.use().queryFirst(sql, userid, password);

        return result != null;
    }

    public static Record getUserByID(String userid) {

        String sql = "select * from " + Constant.TABLE_USER + " where " +
                Constant.USER_ID + " = ?";
        return DbPro.use().findFirst(sql, userid);
    }

    public static Record getHistoryById(String historyid){

        String sql = "select * from " + Constant.TABLE_HISTORY + " where " +
                Constant.HISTORY_ID + " = ?";
        return DbPro.use().findFirst(sql, historyid);
    }

    public static Record getFixedDepositById(String fdid){

        String sql = "select * from " + Constant.TABLE_FIXED_DEPOSIT + " where " +
                Constant.FD_ID + " = ?";
        return DbPro.use().findFirst(sql, fdid);
    }
    public static List<Record> getUserFixedDepositsById(String userid) {

        String sql = "select * from " + Constant.TABLE_FIXED_DEPOSIT + " where " + Constant.USER_ID + " = ?";
        return DbPro.use().find(sql, userid);
    }

    public static void setUserPassword(String userid, String password) {

        Record user = getUserByID(userid);
        user.set(Constant.USER_PASSWORD,password);
        DbPro.use().update(Constant.TABLE_USER,Constant.USER_ID,user);

    }

    public static long getSizeOfUsers() {

        String sql = "select count(*) from " + Constant.TABLE_USER;
        return (long) Db.queryFirst(sql);
    }

    public static long getSizeOfHistorysById(String userid) {

        String sql = "select count(*) from " + Constant.TABLE_HISTORY + " where " + Constant.USER_ID + " = ?";
        return (long) Db.queryFirst(sql, userid);
    }

    public static long getSizeOfFixedDepositsById(String userid) {

        String sql = "select count(*) from " + Constant.TABLE_FIXED_DEPOSIT + " where " + Constant.USER_ID + " = ?";
        return (long) Db.queryFirst(sql, userid);
    }

    public static void saveNewUser(String name, String password, String idcard, String type, String balance) {

        Record user = new Record()
                .set(Constant.USER_NAME, name)
                .set(Constant.USER_PASSWORD, password)
                .set(Constant.USER_IDCARD, idcard)
                .set(Constant.USER_TYPE, type)
                .set(Constant.USER_BALANCE, balance)
                .set(Constant.USER_INTEREST, 0)
                .set(Constant.USER_LAST_SETTLE_INTEREST_DATE, String.valueOf(new Date().getTime()));
        Db.save(Constant.TABLE_USER, user);
        //需要获取主键
        user.get(Constant.USER_ID);

    }

    public static String saveNewHistory(String userid, int type, double amount, long now) {

        Record history = new Record()
                .set(Constant.HISTORY_TYPE, type)
                .set(Constant.USER_ID, userid)
                .set(Constant.HISTORY_AMOUNT, amount)
                .set(Constant.HISTORY_DATE, now);
        Db.save(Constant.TABLE_HISTORY,Constant.HISTORY_ID,history);
        return history.get(Constant.HISTORY_ID).toString();
    }

    public static void deleteAllRecordById(String userid) {

        String sql = "select * from " + Constant.TABLE_HISTORY + " where " + Constant.USER_ID + " = ?";
        List<Record> historys = DbPro.use().find(sql, userid);
        for (int i = 0; i < historys.size(); i++) {
            DbPro.use().delete(Constant.TABLE_HISTORY, Constant.HISTORY_ID, historys.get(i));
        }

        sql = "select * from " + Constant.TABLE_FIXED_DEPOSIT + " where " + Constant.USER_ID + " = ?";
        List<Record> deposits = DbPro.use().find(sql, userid);
        for (int i = 0; i < deposits.size(); i++) {
            DbPro.use().delete(Constant.TABLE_FIXED_DEPOSIT, Constant.FD_ID, deposits.get(i));
        }

        DbPro.use().deleteById(Constant.TABLE_USER, Constant.USER_ID, userid);
    }

    public static Long HowManyDaysFromLastSettle(Record user) {

        Long last = Long.parseLong(user.getStr(Constant.USER_LAST_SETTLE_INTEREST_DATE));
        Long now = new Date().getTime();
        return ((now - last) / (1000 * 60 * 60 * 24));
    }

    public static void isThereAnyFixedDepositsForThisUser(String userid) {

        List<Record> deposits = UserService.getUserFixedDepositsById(userid);
        Record user = UserService.getUserByID(userid);
        Long now = new Date().getTime();

        for (Record deposit : deposits) {
            if (now >= Long.parseLong(deposit.get(Constant.FD_END_DATE)) && deposit.getInt(Constant.FD_IS_VALID) == 0) {

                deposit.set(Constant.FD_IS_VALID, 1);
                user.set(Constant.USER_BALANCE,
                        user.getDouble(Constant.USER_BALANCE)
                                + deposit.getDouble(Constant.FD_AMOUNT)
                                + deposit.getDouble(Constant.FD_INCOME));

                DbPro.use().update(Constant.TABLE_USER, Constant.USER_ID, user);
                DbPro.use().update(Constant.TABLE_FIXED_DEPOSIT, Constant.FD_ID, deposit);

            }
        }
    }

    public static double settleInterestAddButNotAdd(Record user, Long days) {

        if (user.getInt(Constant.USER_TYPE) == 0) {
            return user.getDouble(Constant.USER_BALANCE) * Constant.NORMAL_ACCOUNT_CURRENT_RATE * days;
        } else {
            return user.getDouble(Constant.USER_BALANCE) * Constant.GOLD_ACCOUNT_CURRENT_RATE * days;
        }
    }

    public static void settleInterestAddToInterest(Record user, double interest_add, long now) {

        user.set(Constant.USER_INTEREST, user.getDouble(Constant.USER_INTEREST) + interest_add).set(Constant.USER_LAST_SETTLE_INTEREST_DATE, now);
        DbPro.use().update(Constant.TABLE_USER, Constant.USER_ID, user);
    }

    public static void settleInterestAddAndAmountToBalance(Record user, double interest_add_and_amount, long now) {

        user.set(Constant.USER_BALANCE, user.getDouble(Constant.USER_BALANCE) + user.getDouble(Constant.USER_INTEREST) + interest_add_and_amount)
                .set(Constant.USER_INTEREST, 0)
                .set(Constant.USER_LAST_SETTLE_INTEREST_DATE, now);
        DbPro.use().update(Constant.TABLE_USER, Constant.USER_ID, user);
    }


}
