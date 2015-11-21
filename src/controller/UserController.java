package controller;

import com.jfinal.aop.Before;
import com.jfinal.aop.Clear;
import com.jfinal.core.Controller;
import interceptor.UserAuthInterceptor;
import service.UserService;

import java.util.Objects;

/**
 * Created by ·² on 2015/10/11.
 */
@Before(UserAuthInterceptor.class)
public class UserController extends Controller {

    @Clear
    public void index() {

        renderJsp("user_login.jsp");
    }

    public void home() {

        renderJsp("user_home.jsp");
    }

    @Clear
    public void error() {

        renderJsp("user_error.jsp");
    }

    @Clear
    public void login() {

        String userid = getPara("user_id");
        String password = getPara("user_password");

        if (UserService.login(userid, password)) {

            setSessionAttr("user_id", userid);
            redirect("/user/home?history_page=1&fd_page=1");
        } else {

            redirect("/user/error");
        }
    }

    public void logout(){

        removeSessionAttr("user_id");
        redirect("/user");
    }


    public void saveChangedPassword() {

        String userid = getSessionAttr("user_id");
        String password = getPara("password");
        String password_re = getPara("password_re");

        if (!Objects.equals(password, password_re)|| password.equals("")) {

            redirect("/user/user_change_info.jsp");
        } else {

            UserService.setUserPassword(userid, password);
            redirect("/user/home");
        }

    }
}
