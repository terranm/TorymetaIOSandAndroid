package com.tnmeta.torymeta;

import androidx.annotation.NonNull;
import androidx.navigation.ActionOnlyNavDirections;
import androidx.navigation.NavDirections;

public class NavMainDirections {
  private NavMainDirections() {
  }

  @NonNull
  public static NavDirections actionGlobalSignFlowFragment() {
    return new ActionOnlyNavDirections(R.id.action_global_signFlowFragment);
  }
}
