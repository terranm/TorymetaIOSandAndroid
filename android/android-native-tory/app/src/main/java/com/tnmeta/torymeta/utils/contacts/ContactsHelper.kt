package com.tnmeta.torymeta.utils.contacts

import android.Manifest
import android.database.Cursor
import android.provider.ContactsContract
import androidx.activity.ComponentActivity
import androidx.activity.result.ActivityResultLauncher
import androidx.activity.result.contract.ActivityResultContracts
import androidx.lifecycle.LiveData
import androidx.lifecycle.MutableLiveData
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.ui.CommonAlertDialog
import com.tnmeta.torymeta.ui.CommonLoadingView
import com.tnmeta.torymeta.utils.PermissionHelper
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.launch

data class Contact(val id: String, val name:String) {
    var numbers = ArrayList<String>()
    var emails = ArrayList<String>()
}

class ContactsHelper(private val activity: ComponentActivity) {
    var onPermissionDenied: (() -> Unit)? = null

    private val _contacts = MutableLiveData<ArrayList<Contact>>()
    val contacts: LiveData<ArrayList<Contact>> = _contacts

    companion object {
        private val PERMISSIONS = arrayOf(
            Manifest.permission.READ_CONTACTS
        )
    }

    init {
    }

    /**
     * 모든 연락처를 가져옵니다
     */
    fun fetchContacts() {
        if( !isPermissionGranted() ) {
            requestPermission()
            return
        }

        CoroutineScope(Dispatchers.Main).launch {
            val contactsListAsync = async { getPhoneContacts() }
            val contactNumbersAsync = async { getContactNumbers() }
            val contactEmailAsync = async { getContactEmails() }

            val contacts = contactsListAsync.await()
            val contactNumbers = contactNumbersAsync.await()
            val contactEmails = contactEmailAsync.await()

            // 핸드폰 번호, 이메일 주소 병합
            contacts.forEach {
                contactNumbers[it.id]?.let { numbers ->
                    it.numbers = numbers
                }
                contactEmails[it.id]?.let { emails ->
                    it.emails = emails
                }
            }
            _contacts.postValue(contacts)
        }
    }

    /**
     * 모든 연락처를 가져옵니다 (핸드폰 번호, 이메일 주소 제외)
     */
    private suspend fun getPhoneContacts(): ArrayList<Contact> {
        val contactsList = ArrayList<Contact>()
        val contactsCursor = activity.contentResolver?.query(
            ContactsContract.Contacts.CONTENT_URI,
            null,
            null,
            null,
            ContactsContract.CommonDataKinds.Phone.DISPLAY_NAME + " ASC")
        if (contactsCursor != null && contactsCursor.count > 0) {
            val idIndex = contactsCursor.getColumnIndex(ContactsContract.Contacts._ID)
            val nameIndex = contactsCursor.getColumnIndex(ContactsContract.Contacts.DISPLAY_NAME)
            while (contactsCursor.moveToNext()) {
                val id = contactsCursor.getString(idIndex)
                val name = contactsCursor.getString(nameIndex)
                if (name != null) {
                    contactsList.add(Contact(id, name))
                }
            }
            contactsCursor.close()
        }
        return contactsList
    }

    /**
     * 모든 핸드폰 번호를 가져옵니다
     */
    private suspend fun getContactNumbers(): HashMap<String, ArrayList<String>> {
        val contactsNumberMap = HashMap<String, ArrayList<String>>()
        val phoneCursor: Cursor? = activity.contentResolver.query(
            ContactsContract.CommonDataKinds.Phone.CONTENT_URI,
            null,
            null,
            null,
            null
        )
        if (phoneCursor != null && phoneCursor.count > 0) {
            val contactIdIndex = phoneCursor!!.getColumnIndex(ContactsContract.CommonDataKinds.Phone.CONTACT_ID)
            val numberIndex = phoneCursor.getColumnIndex(ContactsContract.CommonDataKinds.Phone.NUMBER)
            while (phoneCursor.moveToNext()) {
                val contactId = phoneCursor.getString(contactIdIndex)
                val number: String = phoneCursor.getString(numberIndex)
                //check if the map contains key or not, if not then create a new array list with number
                if (contactsNumberMap.containsKey(contactId)) {
                    contactsNumberMap[contactId]?.add(number)
                } else {
                    contactsNumberMap[contactId] = arrayListOf(number)
                }
            }
            //contact contains all the number of a particular contact
            phoneCursor.close()
        }
        return contactsNumberMap
    }

    /**
     * 모든 이메일 주소를 가져옵니다
     */
    private suspend fun getContactEmails(): HashMap<String, ArrayList<String>> {
        val contactsEmailMap = HashMap<String, ArrayList<String>>()
        val emailCursor = activity.contentResolver.query(
            ContactsContract.CommonDataKinds.Email.CONTENT_URI,
            null,
            null,
            null,
            null)
        if (emailCursor != null && emailCursor.count > 0) {
            val contactIdIndex = emailCursor.getColumnIndex(ContactsContract.CommonDataKinds.Email.CONTACT_ID)
            val emailIndex = emailCursor.getColumnIndex(ContactsContract.CommonDataKinds.Email.ADDRESS)
            while (emailCursor.moveToNext()) {
                val contactId = emailCursor.getString(contactIdIndex)
                val email = emailCursor.getString(emailIndex)
                //check if the map contains key or not, if not then create a new array list with email
                if (contactsEmailMap.containsKey(contactId)) {
                    contactsEmailMap[contactId]?.add(email)
                } else {
                    contactsEmailMap[contactId] = arrayListOf(email)
                }
            }
            //contact contains all the emails of a particular contact
            emailCursor.close()
        }
        return contactsEmailMap
    }

    /**
     * READ_CONTACTS 권한을 요청합니다
     */
    private val permissionLauncher: ActivityResultLauncher<Array<String>> =
        activity.registerForActivityResult(ActivityResultContracts.RequestMultiplePermissions()) { permissions ->
            // 권한 허용됨
            if( PermissionHelper.isPermissionGranted(activity, PERMISSIONS) ) {
                fetchContacts()
            }
            // 권한 거부함
            else {
                onPermissionDenied?.let {
                    it()
                }
            }
        }

    fun requestPermission() {
        // 이미 허용
        if( isPermissionGranted() ) {
            return
        }

        // 거부됨
        if( PermissionHelper.shouldShowRequestPermissionRationale(activity, PERMISSIONS) ) {
            CommonAlertDialog.Builder(activity)
                .setCancelable(false)
                .setMessage(R.string.system_alert_permission_denied)
                .setPositiveButton {
                    onPermissionDenied?.let {
                        it()
                    }
                }
                .show()
        }
        // 권한 요청
        else {
            permissionLauncher.launch(PERMISSIONS)
        }
    }

    private fun isPermissionGranted(): Boolean {
        return PermissionHelper.isPermissionGranted(activity, PERMISSIONS)
    }
}