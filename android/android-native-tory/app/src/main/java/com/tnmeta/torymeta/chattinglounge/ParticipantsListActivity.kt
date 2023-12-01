package com.tnmeta.torymeta.chattinglounge


import android.annotation.SuppressLint
import android.content.Intent
import android.os.Bundle
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.LinearLayout
import androidx.core.content.ContextCompat
//import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.bumptech.glide.Glide
import com.bumptech.glide.load.resource.bitmap.CenterCrop
import com.bumptech.glide.load.resource.bitmap.RoundedCorners
import com.google.gson.Gson
import com.tnmeta.torymeta.R
import com.tnmeta.torymeta.base.BaseActivity
import com.tnmeta.torymeta.common.ChattingAction
import com.tnmeta.torymeta.control.delegates.viewBinding
import com.tnmeta.torymeta.control.extension.DividerItemDecoration
import com.tnmeta.torymeta.control.extension.setDivider
import com.tnmeta.torymeta.databinding.ActivityParticipantsListBinding
import com.tnmeta.torymeta.databinding.ParticipantsListItemBinding
import com.tnmeta.torymeta.model.unity.MemberInfo
import com.tnmeta.torymeta.model.unity.ParticipantsListOption
import timber.log.Timber


/**
 * ParticipantsListActivity
 *
 */
class ParticipantsListActivity : BaseActivity(), View.OnClickListener {

    companion object {
        val  TAG : String = ParticipantsListActivity::class.java.simpleName
        const val  ParticipantsListParam = "ParticipantsListParam"
    }

    private val viewBinding by viewBinding(ActivityParticipantsListBinding::inflate)
    private lateinit var mAdapter : ParticipantsRecyclerViewAdapter

    private val mMemberArray = ArrayList<MemberInfo>()
    private var chatRoomId : Int = 0
    private var tableId    : String = ""

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        try {
            viewBinding.apply {
                setContentView(root)
                if (intent.hasExtra(ParticipantsListParam)) {
                    val params = intent.getStringExtra(ParticipantsListParam)

                    val participantsValue = Gson().fromJson(params, ParticipantsListOption::class.java)

                    if (participantsValue.list.size < participantsValue.maxClient) {
                        mMemberArray.addAll(participantsValue.list)

                        val count = participantsValue.maxClient - participantsValue.list.size

                        for (i in 0 until count) {
                            val memberInfo = MemberInfo()
                            memberInfo.isEmpty = true
                            mMemberArray.add(memberInfo)
                        }

                    } else {
                        mMemberArray.addAll(participantsValue.list)
                    }

                    chatRoomId = participantsValue.chatRoomId
                    tableId = participantsValue.tableId

                    txtCount.text = String.format("(%d/%d)", participantsValue.list.size, participantsValue.maxClient)

                    mMemberArray.sortWith(
                        compareBy<MemberInfo> {
                            it.roomMaker
                        }.reversed()
                    )
                }

                mAdapter = ParticipantsRecyclerViewAdapter()
                participantsRecyclerView.apply {
                    layoutManager = LinearLayoutManager(this@ParticipantsListActivity)
                    setDivider(R.drawable.menu_view_divider)
                    adapter = mAdapter
                }

                mAdapter.notifyDataSetChanged()
            }

        }catch (e : Exception){
            Timber.d(e.message)
        }
    }

    override fun onResume() {
        super.onResume()
        setFullScreen()
    }


    /**
     * onClick
     * @param view
     */
    override fun onClick(view: View) {
        when(view.id) {
            R.id.close -> finish()
            R.id.report -> {
                Intent(this, ChattingLoungeReportActivity::class.java).run {
                    putExtra(ChattingLoungeReportActivity.ReportRoomIDParam, chatRoomId.toString())
                    startActivity(this)
                }
            }
        }
    }


    /**
     * ParticipantsRecyclerViewAdapter
     */
    inner class ParticipantsRecyclerViewAdapter : RecyclerView.Adapter<ParticipantsRecyclerViewAdapter.RecycleViewHolder>() {
        override fun getItemCount(): Int = mMemberArray.size

        override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ParticipantsRecyclerViewAdapter.RecycleViewHolder {
            val binding = ParticipantsListItemBinding.inflate(LayoutInflater.from(parent.context), parent, false)
            return RecycleViewHolder(binding)
        }

        override fun onBindViewHolder(holder: ParticipantsRecyclerViewAdapter.RecycleViewHolder, @SuppressLint("RecyclerView") position: Int) {
            try {
                val dataInfo = mMemberArray!![position]
                holder.run {
                    bind(dataInfo)
                    itemView.setOnClickListener {
                        Timber.tag(TAG).d("itemView - $dataInfo")

                        if(dataInfo.isEmpty) {
                            onInvite()
                        }
                    }
                }

            }catch (e : Exception){
                Timber.d(e.message)
            }
        }

        inner class RecycleViewHolder(private var viewBinding: ParticipantsListItemBinding) : RecyclerView.ViewHolder(viewBinding.root) {
            fun bind(item: MemberInfo) {
                with(viewBinding) {
                    item.run {
                        if(!item.isEmpty) {
                            infoLayout.visibility = View.VISIBLE
                            inviteLayout.visibility = View.GONE

                            if(item.roomMaker) {
                                inviteName.apply {
                                    text = String.format("(방장)%s", profileName)
                                    setTextColor((ContextCompat.getColor(this@ParticipantsListActivity,  R.color.tory_purple)))
                                }
                            }else {
                                inviteName.apply {
                                    text = String.format("%s", profileName)
                                    setTextColor((ContextCompat.getColor(this@ParticipantsListActivity,  R.color.tory_black)))
                                }
                            }

                            Glide.with(root.context)
                                .load(imgUrl)
                                .transform(CenterCrop(), RoundedCorners(16))
                                .into(profileImg)
                        }else {
                            infoLayout.visibility = View.GONE
                            inviteLayout.visibility = View.VISIBLE
                        }
                    }
                }
            }
        }
    }




    /**
     * onInvite
     */
    private fun onInvite() = try {
        /*
        sendNativeUnityMessage(type = ChattingAction.RequestInvitable,
                                valueParam = null)

        finish()
         */

         Intent(this, ChattingInviteActivity::class.java).run {
             putExtra(ChattingInviteActivity.InviteParam, tableId)
             startActivity(this)
         }
         finish()

    }catch (e : Exception) {
        Timber.tag(TAG).d(e.message)
    }


}