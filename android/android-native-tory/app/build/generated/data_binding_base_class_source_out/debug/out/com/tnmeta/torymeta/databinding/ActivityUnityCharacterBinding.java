// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.ImageView;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivityUnityCharacterBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final Button button1;

  @NonNull
  public final Button button2;

  @NonNull
  public final Button button3;

  @NonNull
  public final ImageView myCampusBtn;

  @NonNull
  public final ConstraintLayout unity;

  private ActivityUnityCharacterBinding(@NonNull ConstraintLayout rootView, @NonNull Button button1,
      @NonNull Button button2, @NonNull Button button3, @NonNull ImageView myCampusBtn,
      @NonNull ConstraintLayout unity) {
    this.rootView = rootView;
    this.button1 = button1;
    this.button2 = button2;
    this.button3 = button3;
    this.myCampusBtn = myCampusBtn;
    this.unity = unity;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivityUnityCharacterBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivityUnityCharacterBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_unity_character, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivityUnityCharacterBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.button1;
      Button button1 = ViewBindings.findChildViewById(rootView, id);
      if (button1 == null) {
        break missingId;
      }

      id = R.id.button2;
      Button button2 = ViewBindings.findChildViewById(rootView, id);
      if (button2 == null) {
        break missingId;
      }

      id = R.id.button3;
      Button button3 = ViewBindings.findChildViewById(rootView, id);
      if (button3 == null) {
        break missingId;
      }

      id = R.id.myCampusBtn;
      ImageView myCampusBtn = ViewBindings.findChildViewById(rootView, id);
      if (myCampusBtn == null) {
        break missingId;
      }

      id = R.id.unity;
      ConstraintLayout unity = ViewBindings.findChildViewById(rootView, id);
      if (unity == null) {
        break missingId;
      }

      return new ActivityUnityCharacterBinding((ConstraintLayout) rootView, button1, button2,
          button3, myCampusBtn, unity);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
