// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatEditText;
import androidx.appcompat.widget.AppCompatImageButton;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.constraintlayout.widget.Guideline;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivityLectureLoginBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final AppCompatTextView descId;

  @NonNull
  public final AppCompatTextView descPassword;

  @NonNull
  public final AppCompatEditText editId;

  @NonNull
  public final AppCompatEditText editPassword;

  @NonNull
  public final Guideline guideLine01;

  @NonNull
  public final AppCompatImageView imgUnivertyLogo;

  @NonNull
  public final AppCompatImageButton ivBack;

  @NonNull
  public final ConstraintLayout login;

  @NonNull
  public final AppCompatTextView loginDesc;

  @NonNull
  public final ConstraintLayout logoLayout;

  @NonNull
  public final AppCompatTextView title;

  @NonNull
  public final ConstraintLayout titleLayout;

  @NonNull
  public final AppCompatTextView txtLectureInfo;

  @NonNull
  public final AppCompatTextView txtSchool;

  private ActivityLectureLoginBinding(@NonNull ConstraintLayout rootView,
      @NonNull AppCompatTextView descId, @NonNull AppCompatTextView descPassword,
      @NonNull AppCompatEditText editId, @NonNull AppCompatEditText editPassword,
      @NonNull Guideline guideLine01, @NonNull AppCompatImageView imgUnivertyLogo,
      @NonNull AppCompatImageButton ivBack, @NonNull ConstraintLayout login,
      @NonNull AppCompatTextView loginDesc, @NonNull ConstraintLayout logoLayout,
      @NonNull AppCompatTextView title, @NonNull ConstraintLayout titleLayout,
      @NonNull AppCompatTextView txtLectureInfo, @NonNull AppCompatTextView txtSchool) {
    this.rootView = rootView;
    this.descId = descId;
    this.descPassword = descPassword;
    this.editId = editId;
    this.editPassword = editPassword;
    this.guideLine01 = guideLine01;
    this.imgUnivertyLogo = imgUnivertyLogo;
    this.ivBack = ivBack;
    this.login = login;
    this.loginDesc = loginDesc;
    this.logoLayout = logoLayout;
    this.title = title;
    this.titleLayout = titleLayout;
    this.txtLectureInfo = txtLectureInfo;
    this.txtSchool = txtSchool;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivityLectureLoginBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivityLectureLoginBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_lecture_login, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivityLectureLoginBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.desc_id;
      AppCompatTextView descId = ViewBindings.findChildViewById(rootView, id);
      if (descId == null) {
        break missingId;
      }

      id = R.id.desc_password;
      AppCompatTextView descPassword = ViewBindings.findChildViewById(rootView, id);
      if (descPassword == null) {
        break missingId;
      }

      id = R.id.edit_id;
      AppCompatEditText editId = ViewBindings.findChildViewById(rootView, id);
      if (editId == null) {
        break missingId;
      }

      id = R.id.edit_password;
      AppCompatEditText editPassword = ViewBindings.findChildViewById(rootView, id);
      if (editPassword == null) {
        break missingId;
      }

      id = R.id.guide_line_01;
      Guideline guideLine01 = ViewBindings.findChildViewById(rootView, id);
      if (guideLine01 == null) {
        break missingId;
      }

      id = R.id.img_univerty_logo;
      AppCompatImageView imgUnivertyLogo = ViewBindings.findChildViewById(rootView, id);
      if (imgUnivertyLogo == null) {
        break missingId;
      }

      id = R.id.ivBack;
      AppCompatImageButton ivBack = ViewBindings.findChildViewById(rootView, id);
      if (ivBack == null) {
        break missingId;
      }

      id = R.id.login;
      ConstraintLayout login = ViewBindings.findChildViewById(rootView, id);
      if (login == null) {
        break missingId;
      }

      id = R.id.login_desc;
      AppCompatTextView loginDesc = ViewBindings.findChildViewById(rootView, id);
      if (loginDesc == null) {
        break missingId;
      }

      id = R.id.logo_layout;
      ConstraintLayout logoLayout = ViewBindings.findChildViewById(rootView, id);
      if (logoLayout == null) {
        break missingId;
      }

      id = R.id.title;
      AppCompatTextView title = ViewBindings.findChildViewById(rootView, id);
      if (title == null) {
        break missingId;
      }

      id = R.id.title_layout;
      ConstraintLayout titleLayout = ViewBindings.findChildViewById(rootView, id);
      if (titleLayout == null) {
        break missingId;
      }

      id = R.id.txt_lecture_info;
      AppCompatTextView txtLectureInfo = ViewBindings.findChildViewById(rootView, id);
      if (txtLectureInfo == null) {
        break missingId;
      }

      id = R.id.txt_school;
      AppCompatTextView txtSchool = ViewBindings.findChildViewById(rootView, id);
      if (txtSchool == null) {
        break missingId;
      }

      return new ActivityLectureLoginBinding((ConstraintLayout) rootView, descId, descPassword,
          editId, editPassword, guideLine01, imgUnivertyLogo, ivBack, login, loginDesc, logoLayout,
          title, titleLayout, txtLectureInfo, txtSchool);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
