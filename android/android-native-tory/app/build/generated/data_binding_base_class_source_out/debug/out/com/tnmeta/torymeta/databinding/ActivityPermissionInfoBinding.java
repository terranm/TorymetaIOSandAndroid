// Generated by view binder compiler. Do not edit!
package com.tnmeta.torymeta.databinding;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.appcompat.widget.AppCompatImageView;
import androidx.appcompat.widget.AppCompatTextView;
import androidx.constraintlayout.widget.ConstraintLayout;
import androidx.core.widget.NestedScrollView;
import androidx.viewbinding.ViewBinding;
import androidx.viewbinding.ViewBindings;
import com.tnmeta.torymeta.R;
import java.lang.NullPointerException;
import java.lang.Override;
import java.lang.String;

public final class ActivityPermissionInfoBinding implements ViewBinding {
  @NonNull
  private final ConstraintLayout rootView;

  @NonNull
  public final AppCompatTextView bodySensorDesc;

  @NonNull
  public final AppCompatImageView bodySensorIcon;

  @NonNull
  public final ConstraintLayout bodySensorLayout;

  @NonNull
  public final AppCompatTextView bodySensorTitle;

  @NonNull
  public final Button btnOK;

  @NonNull
  public final AppCompatTextView cameraDesc;

  @NonNull
  public final AppCompatImageView cameraIcon;

  @NonNull
  public final ConstraintLayout cameraLayout;

  @NonNull
  public final AppCompatTextView cameraTitle;

  @NonNull
  public final AppCompatTextView desc01;

  @NonNull
  public final AppCompatTextView locationDesc;

  @NonNull
  public final AppCompatImageView locationIcon;

  @NonNull
  public final ConstraintLayout locationLayout;

  @NonNull
  public final AppCompatTextView locationTitle;

  @NonNull
  public final AppCompatTextView noticeDesc;

  @NonNull
  public final AppCompatImageView noticeIcon;

  @NonNull
  public final ConstraintLayout noticeLayout;

  @NonNull
  public final AppCompatTextView noticeTitle;

  @NonNull
  public final AppCompatTextView permissionComment01;

  @NonNull
  public final AppCompatTextView permissionComment02;

  @NonNull
  public final AppCompatTextView permissionTitle;

  @NonNull
  public final ConstraintLayout permissionTitleLayout;

  @NonNull
  public final AppCompatTextView phonebookDesc;

  @NonNull
  public final AppCompatImageView phonebookIcon;

  @NonNull
  public final ConstraintLayout phonebookLayout;

  @NonNull
  public final AppCompatTextView phonebookTitle;

  @NonNull
  public final AppCompatImageView photoAlbumIcon;

  @NonNull
  public final AppCompatTextView photoAlbumIconDesc;

  @NonNull
  public final ConstraintLayout photoAlbumLayout;

  @NonNull
  public final AppCompatTextView photoAlbumTitle;

  @NonNull
  public final AppCompatTextView recordDesc;

  @NonNull
  public final AppCompatImageView recordIcon;

  @NonNull
  public final ConstraintLayout recordLayout;

  @NonNull
  public final AppCompatTextView recordTitle;

  @NonNull
  public final NestedScrollView scrollView;

  private ActivityPermissionInfoBinding(@NonNull ConstraintLayout rootView,
      @NonNull AppCompatTextView bodySensorDesc, @NonNull AppCompatImageView bodySensorIcon,
      @NonNull ConstraintLayout bodySensorLayout, @NonNull AppCompatTextView bodySensorTitle,
      @NonNull Button btnOK, @NonNull AppCompatTextView cameraDesc,
      @NonNull AppCompatImageView cameraIcon, @NonNull ConstraintLayout cameraLayout,
      @NonNull AppCompatTextView cameraTitle, @NonNull AppCompatTextView desc01,
      @NonNull AppCompatTextView locationDesc, @NonNull AppCompatImageView locationIcon,
      @NonNull ConstraintLayout locationLayout, @NonNull AppCompatTextView locationTitle,
      @NonNull AppCompatTextView noticeDesc, @NonNull AppCompatImageView noticeIcon,
      @NonNull ConstraintLayout noticeLayout, @NonNull AppCompatTextView noticeTitle,
      @NonNull AppCompatTextView permissionComment01,
      @NonNull AppCompatTextView permissionComment02, @NonNull AppCompatTextView permissionTitle,
      @NonNull ConstraintLayout permissionTitleLayout, @NonNull AppCompatTextView phonebookDesc,
      @NonNull AppCompatImageView phonebookIcon, @NonNull ConstraintLayout phonebookLayout,
      @NonNull AppCompatTextView phonebookTitle, @NonNull AppCompatImageView photoAlbumIcon,
      @NonNull AppCompatTextView photoAlbumIconDesc, @NonNull ConstraintLayout photoAlbumLayout,
      @NonNull AppCompatTextView photoAlbumTitle, @NonNull AppCompatTextView recordDesc,
      @NonNull AppCompatImageView recordIcon, @NonNull ConstraintLayout recordLayout,
      @NonNull AppCompatTextView recordTitle, @NonNull NestedScrollView scrollView) {
    this.rootView = rootView;
    this.bodySensorDesc = bodySensorDesc;
    this.bodySensorIcon = bodySensorIcon;
    this.bodySensorLayout = bodySensorLayout;
    this.bodySensorTitle = bodySensorTitle;
    this.btnOK = btnOK;
    this.cameraDesc = cameraDesc;
    this.cameraIcon = cameraIcon;
    this.cameraLayout = cameraLayout;
    this.cameraTitle = cameraTitle;
    this.desc01 = desc01;
    this.locationDesc = locationDesc;
    this.locationIcon = locationIcon;
    this.locationLayout = locationLayout;
    this.locationTitle = locationTitle;
    this.noticeDesc = noticeDesc;
    this.noticeIcon = noticeIcon;
    this.noticeLayout = noticeLayout;
    this.noticeTitle = noticeTitle;
    this.permissionComment01 = permissionComment01;
    this.permissionComment02 = permissionComment02;
    this.permissionTitle = permissionTitle;
    this.permissionTitleLayout = permissionTitleLayout;
    this.phonebookDesc = phonebookDesc;
    this.phonebookIcon = phonebookIcon;
    this.phonebookLayout = phonebookLayout;
    this.phonebookTitle = phonebookTitle;
    this.photoAlbumIcon = photoAlbumIcon;
    this.photoAlbumIconDesc = photoAlbumIconDesc;
    this.photoAlbumLayout = photoAlbumLayout;
    this.photoAlbumTitle = photoAlbumTitle;
    this.recordDesc = recordDesc;
    this.recordIcon = recordIcon;
    this.recordLayout = recordLayout;
    this.recordTitle = recordTitle;
    this.scrollView = scrollView;
  }

  @Override
  @NonNull
  public ConstraintLayout getRoot() {
    return rootView;
  }

  @NonNull
  public static ActivityPermissionInfoBinding inflate(@NonNull LayoutInflater inflater) {
    return inflate(inflater, null, false);
  }

  @NonNull
  public static ActivityPermissionInfoBinding inflate(@NonNull LayoutInflater inflater,
      @Nullable ViewGroup parent, boolean attachToParent) {
    View root = inflater.inflate(R.layout.activity_permission_info, parent, false);
    if (attachToParent) {
      parent.addView(root);
    }
    return bind(root);
  }

  @NonNull
  public static ActivityPermissionInfoBinding bind(@NonNull View rootView) {
    // The body of this method is generated in a way you would not otherwise write.
    // This is done to optimize the compiled bytecode for size and performance.
    int id;
    missingId: {
      id = R.id.body_sensor_desc;
      AppCompatTextView bodySensorDesc = ViewBindings.findChildViewById(rootView, id);
      if (bodySensorDesc == null) {
        break missingId;
      }

      id = R.id.body_sensor_icon;
      AppCompatImageView bodySensorIcon = ViewBindings.findChildViewById(rootView, id);
      if (bodySensorIcon == null) {
        break missingId;
      }

      id = R.id.body_sensor_layout;
      ConstraintLayout bodySensorLayout = ViewBindings.findChildViewById(rootView, id);
      if (bodySensorLayout == null) {
        break missingId;
      }

      id = R.id.body_sensor_title;
      AppCompatTextView bodySensorTitle = ViewBindings.findChildViewById(rootView, id);
      if (bodySensorTitle == null) {
        break missingId;
      }

      id = R.id.btnOK;
      Button btnOK = ViewBindings.findChildViewById(rootView, id);
      if (btnOK == null) {
        break missingId;
      }

      id = R.id.camera_desc;
      AppCompatTextView cameraDesc = ViewBindings.findChildViewById(rootView, id);
      if (cameraDesc == null) {
        break missingId;
      }

      id = R.id.camera_icon;
      AppCompatImageView cameraIcon = ViewBindings.findChildViewById(rootView, id);
      if (cameraIcon == null) {
        break missingId;
      }

      id = R.id.camera_layout;
      ConstraintLayout cameraLayout = ViewBindings.findChildViewById(rootView, id);
      if (cameraLayout == null) {
        break missingId;
      }

      id = R.id.camera_title;
      AppCompatTextView cameraTitle = ViewBindings.findChildViewById(rootView, id);
      if (cameraTitle == null) {
        break missingId;
      }

      id = R.id.desc01;
      AppCompatTextView desc01 = ViewBindings.findChildViewById(rootView, id);
      if (desc01 == null) {
        break missingId;
      }

      id = R.id.location_desc;
      AppCompatTextView locationDesc = ViewBindings.findChildViewById(rootView, id);
      if (locationDesc == null) {
        break missingId;
      }

      id = R.id.location_icon;
      AppCompatImageView locationIcon = ViewBindings.findChildViewById(rootView, id);
      if (locationIcon == null) {
        break missingId;
      }

      id = R.id.location_layout;
      ConstraintLayout locationLayout = ViewBindings.findChildViewById(rootView, id);
      if (locationLayout == null) {
        break missingId;
      }

      id = R.id.location_title;
      AppCompatTextView locationTitle = ViewBindings.findChildViewById(rootView, id);
      if (locationTitle == null) {
        break missingId;
      }

      id = R.id.notice_desc;
      AppCompatTextView noticeDesc = ViewBindings.findChildViewById(rootView, id);
      if (noticeDesc == null) {
        break missingId;
      }

      id = R.id.notice_icon;
      AppCompatImageView noticeIcon = ViewBindings.findChildViewById(rootView, id);
      if (noticeIcon == null) {
        break missingId;
      }

      id = R.id.notice_layout;
      ConstraintLayout noticeLayout = ViewBindings.findChildViewById(rootView, id);
      if (noticeLayout == null) {
        break missingId;
      }

      id = R.id.notice_title;
      AppCompatTextView noticeTitle = ViewBindings.findChildViewById(rootView, id);
      if (noticeTitle == null) {
        break missingId;
      }

      id = R.id.permission_comment_01;
      AppCompatTextView permissionComment01 = ViewBindings.findChildViewById(rootView, id);
      if (permissionComment01 == null) {
        break missingId;
      }

      id = R.id.permission_comment_02;
      AppCompatTextView permissionComment02 = ViewBindings.findChildViewById(rootView, id);
      if (permissionComment02 == null) {
        break missingId;
      }

      id = R.id.permission_title;
      AppCompatTextView permissionTitle = ViewBindings.findChildViewById(rootView, id);
      if (permissionTitle == null) {
        break missingId;
      }

      id = R.id.permission_title_layout;
      ConstraintLayout permissionTitleLayout = ViewBindings.findChildViewById(rootView, id);
      if (permissionTitleLayout == null) {
        break missingId;
      }

      id = R.id.phonebook_desc;
      AppCompatTextView phonebookDesc = ViewBindings.findChildViewById(rootView, id);
      if (phonebookDesc == null) {
        break missingId;
      }

      id = R.id.phonebook_icon;
      AppCompatImageView phonebookIcon = ViewBindings.findChildViewById(rootView, id);
      if (phonebookIcon == null) {
        break missingId;
      }

      id = R.id.phonebook_layout;
      ConstraintLayout phonebookLayout = ViewBindings.findChildViewById(rootView, id);
      if (phonebookLayout == null) {
        break missingId;
      }

      id = R.id.phonebook_title;
      AppCompatTextView phonebookTitle = ViewBindings.findChildViewById(rootView, id);
      if (phonebookTitle == null) {
        break missingId;
      }

      id = R.id.photo_album_icon;
      AppCompatImageView photoAlbumIcon = ViewBindings.findChildViewById(rootView, id);
      if (photoAlbumIcon == null) {
        break missingId;
      }

      id = R.id.photo_album_icon_desc;
      AppCompatTextView photoAlbumIconDesc = ViewBindings.findChildViewById(rootView, id);
      if (photoAlbumIconDesc == null) {
        break missingId;
      }

      id = R.id.photo_album_layout;
      ConstraintLayout photoAlbumLayout = ViewBindings.findChildViewById(rootView, id);
      if (photoAlbumLayout == null) {
        break missingId;
      }

      id = R.id.photo_album_title;
      AppCompatTextView photoAlbumTitle = ViewBindings.findChildViewById(rootView, id);
      if (photoAlbumTitle == null) {
        break missingId;
      }

      id = R.id.record_desc;
      AppCompatTextView recordDesc = ViewBindings.findChildViewById(rootView, id);
      if (recordDesc == null) {
        break missingId;
      }

      id = R.id.record_icon;
      AppCompatImageView recordIcon = ViewBindings.findChildViewById(rootView, id);
      if (recordIcon == null) {
        break missingId;
      }

      id = R.id.record_layout;
      ConstraintLayout recordLayout = ViewBindings.findChildViewById(rootView, id);
      if (recordLayout == null) {
        break missingId;
      }

      id = R.id.record_title;
      AppCompatTextView recordTitle = ViewBindings.findChildViewById(rootView, id);
      if (recordTitle == null) {
        break missingId;
      }

      id = R.id.scrollView;
      NestedScrollView scrollView = ViewBindings.findChildViewById(rootView, id);
      if (scrollView == null) {
        break missingId;
      }

      return new ActivityPermissionInfoBinding((ConstraintLayout) rootView, bodySensorDesc,
          bodySensorIcon, bodySensorLayout, bodySensorTitle, btnOK, cameraDesc, cameraIcon,
          cameraLayout, cameraTitle, desc01, locationDesc, locationIcon, locationLayout,
          locationTitle, noticeDesc, noticeIcon, noticeLayout, noticeTitle, permissionComment01,
          permissionComment02, permissionTitle, permissionTitleLayout, phonebookDesc, phonebookIcon,
          phonebookLayout, phonebookTitle, photoAlbumIcon, photoAlbumIconDesc, photoAlbumLayout,
          photoAlbumTitle, recordDesc, recordIcon, recordLayout, recordTitle, scrollView);
    }
    String missingId = rootView.getResources().getResourceName(id);
    throw new NullPointerException("Missing required view with ID: ".concat(missingId));
  }
}
