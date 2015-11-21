package service;

import com.jfinal.plugin.activerecord.DbPro;
import com.jfinal.plugin.activerecord.Record;
import constant.Constant;

/**
 * Created by ·² on 2015/10/15.
 */
public class StaffService {

    public static boolean login(String staffid,String password){

        String sql = "select " + Constant.STAFF_ID + " from " + Constant.TABLE_STAFF + " where " +
                Constant.STAFF_ID + " = ? and " + Constant.STAFF_PASSWORD + " = ?";
        Integer result = DbPro.use().queryFirst(sql,staffid,password);

        return result!=null;
    }

    public static Record getStaffByName(String staffname){

        String sql = "select " + Constant.STAFF_ID + " from " + Constant.TABLE_STAFF + " where " +
                Constant.STAFF_NAME + " = ?";

        Record staff = DbPro.use().findFirst(sql, staffname);
        return staff;
    }

    public static Record getStaffByID(String staffid){

        String sql = "select * from " + Constant.TABLE_STAFF + " where " +
                Constant.STAFF_ID + " = ?";

        Record staff = DbPro.use().findFirst(sql,staffid);
        return staff;
    }
}
