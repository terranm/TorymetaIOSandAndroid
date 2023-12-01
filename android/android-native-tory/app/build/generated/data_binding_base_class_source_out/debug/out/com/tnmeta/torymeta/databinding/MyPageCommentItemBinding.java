// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class MyPageCommentItemBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final ConstraintLayout boardCategory;

  @NonNull
  public final AppCompatImageView boardIcon;

  @NonNull
  public final AppCompatTextView boardName;

  @NonNull
  public final AppCompatTextView content;

  @NonNull
  public final AppCompatTextView date;

  private MyPageCommentItemBinding(@NonNull ConstraintLayout rootView,
      @NonNull ConstraintLayout boardCategory, @NonNull AppCompatImageView boardIcon,
      @NonNull AppCompatTextView boardName, @NonNull AppCompatTextView content,
      @NonNull AppCompatTextView date) {
    this.rootView = rootView;
    this.boardCategory = boardCategory;
    this.boardIcon = boardIcon;
    this.boardName = boardName;
    this.content = content;
    this.date = date;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static MyPageCommentItemBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static MyPageCommentItemBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.my_page_comment_item, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static MyPageCommentItemBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.boardCategory;
      ConstraintLayout boardCategory = ViewBindings.findChildViewById(rootView, id);
      if (boardCategory == null) {
        break missingId;
      }

      id = R.id.boardIcon;
      AppCompatImageView boardIcon = ViewBindings.findChildViewById(rootView, id);
      if (boardIcon == null) {
        break missingId;
      }

      id = R.id.boardName;
      AppCompatTextView boardName = ViewBindings.findChildViewById(rootView, id);
      if (boardName == null) {
        break missingId;
      }

      id = R.id.content;
      AppCompatTextView content = ViewBindings.findChildViewById(rootView, id);
      if (content == null) {
        break missingId;
      }

      id = R.id.date;
      AppCompatTextView date = ViewBindings.findChildViewById(rootView, id);
      if (date == null) {
        break missingId;
      }

      return new MyPageCommentItemBinding((ConstraintLayout) rootView, boardCategory, boardIcon,
          boardName, content, date);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
