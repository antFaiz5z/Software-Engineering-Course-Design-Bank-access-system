package constant;

/**
 * Created by 凡 on 2015/10/13.
 */
public class Constant {

    public static final double NORMAL_ACCOUNT_INITIAL_AMOUNT = 10;                 //普通储户初始应存最小金额
    public static final double GOLD_ACCOUNT_INITIAL_AMOUNT = 100;                  //金卡储户初始应存最小金额

    public static final double NORMAL_ACCOUNT_CURRENT_RATE = 0.002;                 //普通储户活期利率
    public static final double NORMAL_ACCOUNT_PERIODIC_RATE_OF_HALF_YEAR = 0.02;    //普通储户半年定期利率
    public static final double NORMAL_ACCOUNT_PERIODIC_RATE_OF_ONE_YEAR = 0.03;     //普通储户一年定期利率
    public static final double GOLD_ACCOUNT_CURRENT_RATE = 0.012;                   //金卡储户活期利率
    public static final double GOLD_ACCOUNT_PERIODIC_RATE_OF_ONE_YEAR = 0.045;      //金卡储户一年定期利率

    public static final String DB_NAME = "bank";

    public static final String TABLE_USER = "user";
    public static final String USER_ID = "user_id";
    public static final String USER_NAME = "user_name";
    public static final String USER_PASSWORD = "user_password";
    public static final String USER_TYPE = "user_type";                        //0是普通储户，1是金卡储户
    public static final String USER_BALANCE = "user_balance";
    public static final String USER_INTEREST = "user_interest";
    public static final String USER_IDCARD = "user_idcard";
    public static final String USER_LAST_SETTLE_INTEREST_DATE = "user_last_settle_interest_date";


    public static final String TABLE_STAFF = "staff";
    public static final String STAFF_ID = "staff_id";
    public static final String STAFF_NAME = "staff_name";
    public static final String STAFF_PASSWORD = "staff_password";

    public static final String TABLE_HISTORY = "history";
    public static final String HISTORY_ID = "history_id";
    public static final String HISTORY_TYPE = "history_type";               //0是取款，1是活期取款，2是定期取款
    public static final String HISTORY_AMOUNT = "history_amount";
    public static final String HISTORY_DATE = "history_date";

    public static final String TABLE_FIXED_DEPOSIT = "fixed_deposit";
    public static final String FD_ID = "fd_id";
    public static final String FD_TYPE = "fd_type";                         //0是半年期，1是一年期
    public static final String FD_START_DATE = "fd_start_date";
    public static final String FD_END_DATE = "fd_end_date";
    public static final String FD_AMOUNT = "fd_amount";
    public static final String FD_INCOME = "fd_income";
    public static final String FD_IS_VALID = "fd_is_valid";                //0是有效，1是无效

}
