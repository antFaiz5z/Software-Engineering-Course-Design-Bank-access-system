package validator;

import com.jfinal.core.Controller;
import com.jfinal.validate.Validator;

/**
 * Created by �� on 2015/10/23.
 */
public class UserLoginValidator extends Validator {

    private static final String idPattern = "[0-9]{1,20}";
    private static final String passwordPattern = "[0-9]{1,6}";

    @Override
    protected void validate(Controller controller) {

        validateRegex("user_id",idPattern,"idError","�Ƿ��˺�");
        validateRegex("user_password",passwordPattern,"passwordError","��λ����");
    }

    @Override
    protected void handleError(Controller controller) {

        controller.redirect("/user/error");
    }
}
