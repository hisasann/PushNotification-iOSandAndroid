package com.example.sample_gcm_client;

import android.app.Activity;
import android.os.Bundle;
import android.view.Menu;

import com.google.android.gcm.GCMRegistrar;

public class MainActivity extends Activity {

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        GCMRegistrar.checkDevice(this);
        GCMRegistrar.checkManifest(this);
        final String regId = GCMRegistrar.getRegistrationId(this);

        if (regId.equals("")) {
            System.out.println("not registered");
            GCMRegistrar.register(this, "1111111111111");   // プロジェクトコード
        } else {
            System.out.println("Tag Already registered");
        }
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        getMenuInflater().inflate(R.menu.activity_main, menu);
        return true;
    }
}

