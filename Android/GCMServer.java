import java.io.IOException;

import com.google.android.gcm.server.Constants;
import com.google.android.gcm.server.Message;
import com.google.android.gcm.server.Result;
import com.google.android.gcm.server.Sender;

/**
 * Copyright(c) hisasann</br>
 */

/**
 * FIXME 機能説明をここに記述してください.<br>
 *
 * @author hisasann
 */
public class Main {

    /**
     * @param args
     * @throws IOException
     */
    public static void main(String[] args) throws IOException {
        Sender sender = new Sender("l;kajdsflkjadslfkjadlfkjalkdsjfaslkdfj");       // API key
        Message message = new Message.Builder().addData("badge", "2").addData("alert", "Push通知を受信しました").build();
        // tokenは事前にGCMIntentService.javaのonRegisteredよりメモしておく
        Result result = sender
            .send(
                    message,
                    "lkajdklfjaldksfjalkdsfalkdjfalsdjflkadjf",     // token
                    5);

        if (result.getMessageId() != null) {
            System.out.println("result.getMessageId() - " + result.getMessageId());
            String canonicalRegId = result.getCanonicalRegistrationId();
            if (canonicalRegId != null) {
                // same device has more than on registration ID: update database
                System.out.println("regist");
            }
        } else {
            String error = result.getErrorCodeName();
            System.out.println("error - " + error);
            if (error.equals(Constants.ERROR_NOT_REGISTERED)) {
                // application has been removed from device - unregister database
                System.out.println("unregist");
            }
        }
    }
}

