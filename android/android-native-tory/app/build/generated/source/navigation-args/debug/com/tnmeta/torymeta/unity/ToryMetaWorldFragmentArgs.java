package com.tnmeta.torymeta.unity;

import android.os.Bundle;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.lifecycle.SavedStateHandle;
import androidx.navigation.NavArgs;
import com.tnmeta.torymeta.model.unity.SwitchScene;
import java.io.Serializable;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class ToryMetaWorldFragmentArgs implements NavArgs {
  private final HashMap arguments = new HashMap();

  private ToryMetaWorldFragmentArgs() {
  }

  @SuppressWarnings("unchecked")
  private ToryMetaWorldFragmentArgs(HashMap argumentsMap) {
    this.arguments.putAll(argumentsMap);
  }

  @NonNull
  @SuppressWarnings({
      "unchecked",
      "deprecation"
  })
  public static ToryMetaWorldFragmentArgs fromBundle(@NonNull Bundle bundle) {
    ToryMetaWorldFragmentArgs __result = new ToryMetaWorldFragmentArgs();
    bundle.setClassLoader(ToryMetaWorldFragmentArgs.class.getClassLoader());
    if (bundle.containsKey("param")) {
      SwitchScene param;
      if (Parcelable.class.isAssignableFrom(SwitchScene.class) || Serializable.class.isAssignableFrom(SwitchScene.class)) {
        param = (SwitchScene) bundle.get("param");
      } else {
        throw new UnsupportedOperationException(SwitchScene.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
      }
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("param", param);
    } else {
      throw new IllegalArgumentException("Required argument \"param\" is missing and does not have an android:defaultValue");
    }
    return __result;
  }

  @NonNull
  @SuppressWarnings("unchecked")
  public static ToryMetaWorldFragmentArgs fromSavedStateHandle(
      @NonNull SavedStateHandle savedStateHandle) {
    ToryMetaWorldFragmentArgs __result = new ToryMetaWorldFragmentArgs();
    if (savedStateHandle.contains("param")) {
      SwitchScene param;
      param = savedStateHandle.get("param");
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      __result.arguments.put("param", param);
    } else {
      throw new IllegalArgumentException("Required argument \"param\" is missing and does not have an android:defaultValue");
    }
    return __result;
  }

  @SuppressWarnings("unchecked")
  @NonNull
  public SwitchScene getParam() {
    return (SwitchScene) arguments.get("param");
  }

  @SuppressWarnings("unchecked")
  @NonNull
  public Bundle toBundle() {
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

  @SuppressWarnings("unchecked")
  @NonNull
  public SavedStateHandle toSavedStateHandle() {
    SavedStateHandle __result = new SavedStateHandle();
    if (arguments.containsKey("param")) {
      SwitchScene param = (SwitchScene) arguments.get("param");
      if (Parcelable.class.isAssignableFrom(SwitchScene.class) || param == null) {
        __result.set("param", Parcelable.class.cast(param));
      } else if (Serializable.class.isAssignableFrom(SwitchScene.class)) {
        __result.set("param", Serializable.class.cast(param));
      } else {
        throw new UnsupportedOperationException(SwitchScene.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
      }
    }
    return __result;
  }

  @Override
  public boolean equals(Object object) {
    if (this == object) {
        return true;
    }
    if (object == null || getClass() != object.getClass()) {
        return false;
    }
    ToryMetaWorldFragmentArgs that = (ToryMetaWorldFragmentArgs) object;
    if (arguments.containsKey("param") != that.arguments.containsKey("param")) {
      return false;
    }
    if (getParam() != null ? !getParam().equals(that.getParam()) : that.getParam() != null) {
      return false;
    }
    return true;
  }

  @Override
  public int hashCode() {
    int result = 1;
    result = 31 * result + (getParam() != null ? getParam().hashCode() : 0);
    return result;
  }

  @Override
  public String toString() {
    return "ToryMetaWorldFragmentArgs{"
        + "param=" + getParam()
        + "}";
  }

  public static final class Builder {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    public Builder(@NonNull ToryMetaWorldFragmentArgs original) {
      this.arguments.putAll(original.arguments);
    }

    @SuppressWarnings("unchecked")
    public Builder(@NonNull SwitchScene param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
    }

    @NonNull
    public ToryMetaWorldFragmentArgs build() {
      ToryMetaWorldFragmentArgs result = new ToryMetaWorldFragmentArgs(arguments);
      return result;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public Builder setParam(@NonNull SwitchScene param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
      return this;
    }

    @SuppressWarnings({"unchecked","GetterOnBuilder"})
    @NonNull
    public SwitchScene getParam() {
      return (SwitchScene) arguments.get("param");
    }
  }
}
