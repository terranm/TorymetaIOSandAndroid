// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatButton;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class OpenedChattingLoungeListItemBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final AppCompatTextView chattingCreator;

  @NonNull
  public final AppCompatTextView chattingTitle;

  @NonNull
  public final AppCompatButton enter;

  @NonNull
  public final AppCompatTextView headCount;

  @NonNull
  public final AppCompatImageView imgHeadCount;

  @NonNull
  public final AppCompatImageView lock;

  @NonNull
  public final AppCompatImageView profile;

  @NonNull
  public final ConstraintLayout profileLayout;

  private OpenedChattingLoungeListItemBinding(@NonNull ConstraintLayout rootView,
      @NonNull AppCompatTextView chattingCreator, @NonNull AppCompatTextView chattingTitle,
      @NonNull AppCompatButton enter, @NonNull AppCompatTextView headCount,
      @NonNull AppCompatImageView imgHeadCount, @NonNull AppCompatImageView lock,
      @NonNull AppCompatImageView profile, @NonNull ConstraintLayout profileLayout) {
    this.rootView = rootView;
    this.chattingCreator = chattingCreator;
    this.chattingTitle = chattingTitle;
    this.enter = enter;
    this.headCount = headCount;
    this.imgHeadCount = imgHeadCount;
    this.lock = lock;
    this.profile = profile;
    this.profileLayout = profileLayout;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static OpenedChattingLoungeListItemBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static OpenedChattingLoungeListItemBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.opened_chatting_lounge_list_item, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static OpenedChattingLoungeListItemBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.chatting_creator;
      AppCompatTextView chattingCreator = ViewBindings.findChildViewById(rootView, id);
      if (chattingCreator == null) {
        break missingId;
      }

      id = R.id.chatting_title;
      AppCompatTextView chattingTitle = ViewBindings.findChildViewById(rootView, id);
      if (chattingTitle == null) {
        break missingId;
      }

      id = R.id.enter;
      AppCompatButton enter = ViewBindings.findChildViewById(rootView, id);
      if (enter == null) {
        break missingId;
      }

      id = R.id.head_count;
      AppCompatTextView headCount = ViewBindings.findChildViewById(rootView, id);
      if (headCount == null) {
        break missingId;
      }

      id = R.id.img_head_count;
      AppCompatImageView imgHeadCount = ViewBindings.findChildViewById(rootView, id);
      if (imgHeadCount == null) {
        break missingId;
      }

      id = R.id.lock;
      AppCompatImageView lock = ViewBindings.findChildViewById(rootView, id);
      if (lock == null) {
        break missingId;
      }

      id = R.id.profile;
      AppCompatImageView profile = ViewBindings.findChildViewById(rootView, id);
      if (profile == null) {
        break missingId;
      }

      id = R.id.profile_layout;
      ConstraintLayout profileLayout = ViewBindings.findChildViewById(rootView, id);
      if (profileLayout == null) {
        break missingId;
      }

      return new OpenedChattingLoungeListItemBinding((ConstraintLayout) rootView, chattingCreator,
          chattingTitle, enter, headCount, imgHeadCount, lock, profile, profileLayout);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
