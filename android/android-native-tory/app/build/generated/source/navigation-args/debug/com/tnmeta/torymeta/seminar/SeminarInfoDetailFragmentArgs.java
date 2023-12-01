package com.tnmeta.torymeta.seminar;

import android.os.Bundle;
import android.os.Parcelable;
import androidx.annotation.NonNull;
import androidx.lifecycle.SavedStateHandle;
import androidx.navigation.NavArgs;
import com.tnmeta.torymeta.seminar.model.SeminarInfo;
import java.io.Serializable;
import java.lang.IllegalArgumentException;
import java.lang.Object;
import java.lang.Override;
import java.lang.String;
import java.lang.SuppressWarnings;
import java.util.HashMap;

public class SeminarInfoDetailFragmentArgs implements NavArgs {
  private final HashMap arguments = new HashMap();

  private SeminarInfoDetailFragmentArgs() {
  }

  @SuppressWarnings("unchecked")
  private SeminarInfoDetailFragmentArgs(HashMap argumentsMap) {
    this.arguments.putAll(argumentsMap);
  }

  @NonNull
  @SuppressWarnings({
      "unchecked",
      "deprecation"
  })
  public static SeminarInfoDetailFragmentArgs fromBundle(@NonNull Bundle bundle) {
    SeminarInfoDetailFragmentArgs __result = new SeminarInfoDetailFragmentArgs();
    bundle.setClassLoader(SeminarInfoDetailFragmentArgs.class.getClassLoader());
    if (bundle.containsKey("param")) {
      SeminarInfo param;
      if (Parcelable.class.isAssignableFrom(SeminarInfo.class) || Serializable.class.isAssignableFrom(SeminarInfo.class)) {
        param = (SeminarInfo) bundle.get("param");
      } else {
        throw new UnsupportedOperationException(SeminarInfo.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
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
  public static SeminarInfoDetailFragmentArgs fromSavedStateHandle(
      @NonNull SavedStateHandle savedStateHandle) {
    SeminarInfoDetailFragmentArgs __result = new SeminarInfoDetailFragmentArgs();
    if (savedStateHandle.contains("param")) {
      SeminarInfo param;
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
  public SeminarInfo getParam() {
    return (SeminarInfo) arguments.get("param");
  }

  @SuppressWarnings("unchecked")
  @NonNull
  public Bundle toBundle() {
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

  @SuppressWarnings("unchecked")
  @NonNull
  public SavedStateHandle toSavedStateHandle() {
    SavedStateHandle __result = new SavedStateHandle();
    if (arguments.containsKey("param")) {
      SeminarInfo param = (SeminarInfo) arguments.get("param");
      if (Parcelable.class.isAssignableFrom(SeminarInfo.class) || param == null) {
        __result.set("param", Parcelable.class.cast(param));
      } else if (Serializable.class.isAssignableFrom(SeminarInfo.class)) {
        __result.set("param", Serializable.class.cast(param));
      } else {
        throw new UnsupportedOperationException(SeminarInfo.class.getName() + " must implement Parcelable or Serializable or must be an Enum.");
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
    SeminarInfoDetailFragmentArgs that = (SeminarInfoDetailFragmentArgs) object;
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
    return "SeminarInfoDetailFragmentArgs{"
        + "param=" + getParam()
        + "}";
  }

  public static final class Builder {
    private final HashMap arguments = new HashMap();

    @SuppressWarnings("unchecked")
    public Builder(@NonNull SeminarInfoDetailFragmentArgs original) {
      this.arguments.putAll(original.arguments);
    }

    @SuppressWarnings("unchecked")
    public Builder(@NonNull SeminarInfo param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
    }

    @NonNull
    public SeminarInfoDetailFragmentArgs build() {
      SeminarInfoDetailFragmentArgs result = new SeminarInfoDetailFragmentArgs(arguments);
      return result;
    }

    @NonNull
    @SuppressWarnings("unchecked")
    public Builder setParam(@NonNull SeminarInfo param) {
      if (param == null) {
        throw new IllegalArgumentException("Argument \"param\" is marked as non-null but was passed a null value.");
      }
      this.arguments.put("param", param);
      return this;
    }

    @SuppressWarnings({"unchecked","GetterOnBuilder"})
    @NonNull
    public SeminarInfo getParam() {
      return (SeminarInfo) arguments.get("param");
    }
  }
}
