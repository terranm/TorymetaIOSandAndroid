package com.tnmeta.torymeta.web;

import androidx.annotation.NonNull;
import androidx.navigation.ActionOnlyNavDirections;
import androidx.navigation.NavDirections;
import com.tnmeta.torymeta.NavMainDirections;
import com.tnmeta.torymeta.R;

public class ToryWebFragmentDirections {
  private ToryWebFragmentDirections() {
  }

  @NonNull
  public static NavDirections actionSignOutFragment() {
    return new ActionOnlyNavDirections(R.id.action_sign_out_fragment);
  }

  @NonNull
  public static NavDirections actionGlobalSignFlowFragment() {
    return NavMainDirections.actionGlobalSignFlowFragment();
  }
}
