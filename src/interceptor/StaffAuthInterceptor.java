package interceptor;

import com.jfinal.aop.Interceptor;
import com.jfinal.aop.Invocation;

/**
 * Created by ·² on 2015/10/20.
 */
public class StaffAuthInterceptor implements Interceptor {
    @Override
    public void intercept(Invocation invocation) {
        invocation.invoke();

        if (invocation.getController().getSessionAttr("staff_id") == null) {
            invocation.getController().redirect("/staff");
        }
    }
}
