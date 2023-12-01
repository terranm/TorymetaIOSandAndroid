package com.tnmeta.torymeta.intro;

import androidx.annotation.NonNull;
import androidx.navigation.ActionOnlyNavDirections;
import androidx.navigation.NavDirections;
import com.tnmeta.torymeta.NavMainDirections;
import com.tnmeta.torymeta.R;

public class SplashFragmentDirections {
  private SplashFragmentDirections() {
  }

  @NonNull
  public static NavDirections actionSplashToMainfragment() {
    return new ActionOnlyNavDirections(R.id.action_splash_to_mainfragment);
  }

  @NonNull
  public static NavDirections actionGlobalSignFlowFragment() {
    return NavMainDirections.actionGlobalSignFlowFragment();
  }
}
