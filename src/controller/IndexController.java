package controller;

import com.jfinal.core.Controller;

/**
 * Created by �� on 2015/10/11.
 */
public class IndexController extends Controller {

    public void index(){

        renderJsp("index.jsp");
    }
}
