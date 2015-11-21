package constant;

/**
 * Created by �� on 2015/10/13.
 */
public class Constant {

    public static final double NORMAL_ACCOUNT_INITIAL_AMOUNT = 10;                 //��ͨ������ʼӦ����С���
    public static final double GOLD_ACCOUNT_INITIAL_AMOUNT = 100;                  //�𿨴�����ʼӦ����С���

    public static final double NORMAL_ACCOUNT_CURRENT_RATE = 0.002;                 //��ͨ������������
    public static final double NORMAL_ACCOUNT_PERIODIC_RATE_OF_HALF_YEAR = 0.02;    //��ͨ�������궨������
    public static final double NORMAL_ACCOUNT_PERIODIC_RATE_OF_ONE_YEAR = 0.03;     //��ͨ����һ�궨������
    public static final double GOLD_ACCOUNT_CURRENT_RATE = 0.012;                   //�𿨴�����������
    public static final double GOLD_ACCOUNT_PERIODIC_RATE_OF_ONE_YEAR = 0.045;      //�𿨴���һ�궨������

    public static final String DB_NAME = "bank";

    public static final String TABLE_USER = "user";
    public static final String USER_ID = "user_id";
    public static final String USER_NAME = "user_name";
    public static final String USER_PASSWORD = "user_password";
    public static final String USER_TYPE = "user_type";                        //0����ͨ������1�ǽ𿨴���
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
    public static final String HISTORY_TYPE = "history_type";               //0��ȡ�1�ǻ���ȡ�2�Ƕ���ȡ��
    public static final String HISTORY_AMOUNT = "history_amount";
    public static final String HISTORY_DATE = "history_date";

    public static final String TABLE_FIXED_DEPOSIT = "fixed_deposit";
    public static final String FD_ID = "fd_id";
    public static final String FD_TYPE = "fd_type";                         //0�ǰ����ڣ�1��һ����
    public static final String FD_START_DATE = "fd_start_date";
    public static final String FD_END_DATE = "fd_end_date";
    public static final String FD_AMOUNT = "fd_amount";
    public static final String FD_INCOME = "fd_income";
    public static final String FD_IS_VALID = "fd_is_valid";                //0����Ч��1����Ч

}
