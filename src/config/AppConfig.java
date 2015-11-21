package config;

import com.jfinal.config.*;
import com.jfinal.core.JFinal;
import com.jfinal.ext.handler.ContextPathHandler;
import com.jfinal.plugin.activerecord.ActiveRecordPlugin;
import com.jfinal.plugin.c3p0.C3p0Plugin;
import com.jfinal.render.ViewType;
import constant.Constant;
import controller.IndexController;
import controller.StaffController;
import controller.UserController;
import model.FixedDeposit;
import model.History;
import model.Staff;
import model.User;

/**
 * Created by ·² on 2015/10/11.
 */
public class AppConfig extends JFinalConfig {
    @Override
    public void configConstant(Constants constants) {
        //PropKit.use("db_config.txt");
        constants.setEncoding("UTF-8");
        constants.setDevMode(true);
        constants.setViewType(ViewType.JSP);
    }

    @Override
    public void configRoute(Routes routes) {


        routes.add("/", IndexController.class);
        routes.add("/user", UserController.class);
        routes.add("/staff", StaffController.class);
    }

    @Override
    public void configPlugin(Plugins plugins) {
        loadPropertyFile("db_config.txt");
        C3p0Plugin cp = new C3p0Plugin(getProperty("jdbcUrl"), getProperty("user"), getProperty("password"));

        //C3p0Plugin cp = new C3p0Plugin("jdbc:mysql://localhost/"+ Constant.DB_NAME, "root", "1234");
        plugins.add(cp);
        ActiveRecordPlugin arp = new ActiveRecordPlugin(cp);
        plugins.add(arp);

        arp.addMapping(Constant.TABLE_USER, User.class);
        arp.addMapping(Constant.TABLE_STAFF, Staff.class);
        arp.addMapping(Constant.TABLE_HISTORY, History.class);
        arp.addMapping(Constant.TABLE_FIXED_DEPOSIT, FixedDeposit.class);
    }

    @Override
    public void configInterceptor(Interceptors interceptors) {

    }

    @Override
    public void configHandler(Handlers handlers) {
        handlers.add(new ContextPathHandler("base_path"));
    }

    public static void main(String... args) {
        JFinal.start("web", 8080, "/", 5);
    }

}
