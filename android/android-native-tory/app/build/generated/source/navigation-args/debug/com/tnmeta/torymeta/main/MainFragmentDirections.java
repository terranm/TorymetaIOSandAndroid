package com.tnmeta.torymeta.main;

import android.os.Bundle;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.navigation.ActionOnlyNavDirections;
import androidx.navigation.NavDirections;
import com.tnmeta.torymeta.NavMainDirections;
import com.tnmeta.torymeta.R;
import com.tnmeta.torymeta.model.unity.SwitchScene;
import com.tnmeta.torymeta.seminar.model.SeminarInfo;
import java.io.Serializable;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class MainFragmentDirections {
  private MainFragmentDirections() {
  }

  @NonNull
  public static NavDirections actionMainToAvatarProfile() {
    return new ActionOnlyNavDirections(R.id.action_main_to_avatar_profile);
  }

  @NonNull
  public static ActionMainToTorymetaWorld actionMainToTorymetaWorld(@NonNull SwitchScene param) {
    return new ActionMainToTorymetaWorld(param);
  }

  @NonNull
  public static NavDirections actionMainToSeminarMain() {
    return new ActionOnlyNavDirections(R.id.action_main_to_seminar_main);
  }

  @NonNull
  public static NavDirections actionMainToChattingLounge() {
    return new ActionOnlyNavDirections(R.id.action_main_to_chatting_lounge);
  }

  @NonNull
  public static ActionMainToSeminarDetail actionMainToSeminarDetail(@NonNull SeminarInfo param) {
    return new ActionMainToSeminarDetail(param);
  }

  @NonNull
  public static NavDirections actionGlobalSignFlowFragment() {
    return NavMainDirections.actionGlobalSignFlowFragment();
  }

  public static class ActionMainToTorymetaWorld implements NavDirections {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    private ActionMainToTorymetaWorld(@NonNull SwitchScene param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionMainToTorymetaWorld setParam(@NonNull SwitchScene param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
      return this;
    }

    @Override
    @SuppressWarnings("unchecked")
    @NonNull
    public Bundle getArguments() {
      Bundle __result = new Bundle();
      if (arguments.containsKey("param")) {
        SwitchScene param = (SwitchScene) arguments.get("param");
        if (Parcelable.class.isAssignableFrom(SwitchScene.class) || param == null) {
          __result.putParcelable("param", Parcelable.class.cast(param));
        } else if (Serializable.class.isAssignableFrom(SwitchScene.class)) {
          __result.putSerializable("param", Serializable.class.cast(param));
        } else {
          throw new UnsupportedOperationException(SwitchScene.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
        }
      }
      return __result;
    }

    @Override
    public int getActionId() {
      return R.id.action_main_to_torymeta_world;
    }

    @SuppressWarnings("unchecked")
    @NonNull
    public SwitchScene getParam() {
      return (SwitchScene) arguments.get("param");
    }

    @Override
    public boolean equals(Object object) {
      if (this == object) {
          return true;
      }
      if (object == null || getClass() != object.getClass()) {
          return false;
      }
      ActionMainToTorymetaWorld that = (ActionMainToTorymetaWorld) object;
      if (arguments.containsKey("param") != that.arguments.containsKey("param")) {
        return false;
      }
      if (getParam() != null ? !getParam().equals(that.getParam()) : that.getParam() != null) {
        return false;
      }
      if (getActionId() != that.getActionId()) {
        return false;
      }
      return true;
    }

    @Override
    public int hashCode() {
      int result = 1;
      result = 31 * result + (getParam() != null ? getParam().hashCode() : 0);
      result = 31 * result + getActionId();
      return result;
    }

    @Override
    public String toString() {
      return "ActionMainToTorymetaWorld(actionId=" + getActionId() + "){"
          + "param=" + getParam()
          + "}";
    }
  }

  public static class ActionMainToSeminarDetail implements NavDirections {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    private ActionMainToSeminarDetail(@NonNull SeminarInfo param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionMainToSeminarDetail setParam(@NonNull SeminarInfo param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
      return this;
    }

    @Override
    @SuppressWarnings("unchecked")
    @NonNull
    public Bundle getArguments() {
      Bundle __result = new Bundle();
      if (arguments.containsKey("param")) {
        SeminarInfo param = (SeminarInfo) arguments.get("param");
        if (Parcelable.class.isAssignableFrom(SeminarInfo.class) || param == null) {
          __result.putParcelable("param", Parcelable.class.cast(param));
        } else if (Serializable.class.isAssignableFrom(SeminarInfo.class)) {
          __result.putSerializable("param", Serializable.class.cast(param));
        } else {
          throw new UnsupportedOperationException(SeminarInfo.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
        }
      }
      return __result;
    }

    @Override
    public int getActionId() {
      return R.id.action_main_to_seminar_detail;
    }

    @SuppressWarnings("unchecked")
    @NonNull
    public SeminarInfo getParam() {
      return (SeminarInfo) arguments.get("param");
    }

    @Override
    public boolean equals(Object object) {
      if (this == object) {
          return true;
      }
      if (object == null || getClass() != object.getClass()) {
          return false;
      }
      ActionMainToSeminarDetail that = (ActionMainToSeminarDetail) object;
      if (arguments.containsKey("param") != that.arguments.containsKey("param")) {
        return false;
      }
      if (getParam() != null ? !getParam().equals(that.getParam()) : that.getParam() != null) {
        return false;
      }
      if (getActionId() != that.getActionId()) {
        return false;
      }
      return true;
    }

    @Override
    public int hashCode() {
      int result = 1;
      result = 31 * result + (getParam() != null ? getParam().hashCode() : 0);
      result = 31 * result + getActionId();
      return result;
    }

    @Override
    public String toString() {
      return "ActionMainToSeminarDetail(actionId=" + getActionId() + "){"
          + "param=" + getParam()
          + "}";
    }
  }
}
