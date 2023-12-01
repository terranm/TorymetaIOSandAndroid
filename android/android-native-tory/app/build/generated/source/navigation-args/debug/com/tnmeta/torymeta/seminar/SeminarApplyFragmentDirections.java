package com.tnmeta.torymeta.seminar;

import android.os.Bundle;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.navigation.NavDirections;
import com.tnmeta.torymeta.NavMainDirections;
import com.tnmeta.torymeta.R;
import com.tnmeta.torymeta.model.unity.SwitchScene;
import java.io.Serializable;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class SeminarApplyFragmentDirections {
  private SeminarApplyFragmentDirections() {
  }

  @NonNull
  public static ActionSeminarApplyToTorymetaWorld actionSeminarApplyToTorymetaWorld(
      @NonNull SwitchScene param) {
    return new ActionSeminarApplyToTorymetaWorld(param);
  }

  @NonNull
  public static NavDirections actionGlobalSignFlowFragment() {
    return NavMainDirections.actionGlobalSignFlowFragment();
  }

  public static class ActionSeminarApplyToTorymetaWorld implements NavDirections {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    private ActionSeminarApplyToTorymetaWorld(@NonNull SwitchScene param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public ActionSeminarApplyToTorymetaWorld setParam(@NonNull SwitchScene param) {
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
      return R.id.action_seminar_apply_to_torymeta_world;
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
      ActionSeminarApplyToTorymetaWorld that = (ActionSeminarApplyToTorymetaWorld) object;
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
      return "ActionSeminarApplyToTorymetaWorld(actionId=" + getActionId() + "){"
          + "param=" + getParam()
          + "}";
    }
  }
}
