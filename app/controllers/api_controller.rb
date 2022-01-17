class ApiController < ApplicationController
  include ActionView::Helpers::DateHelper
  include ApplicationHelper

  after_filter :cors_set_access_control_headers

  def index
    # TODO: Temporary only
    render json: {"forums_overview": "", "chats_overview": "", "preferences": {"overview": "", "notifications_desc": ""}, "community_rules": {"overview": "", "content": ""}, "survey": {"delay": 90000, "expiry": 30, "link": "http://dale.org.au", "content": "Here at the DALE community \u2013 we love a good chat! We've been working on running some new chats, but our live chat page is having a bit of a tune up. If you've registered to come along and haven't been able to get in we hope to have that resolved really soon. Thanks for your patience."}, "footer": {"get_support": "Sometimes we all need a bit more support. If you are in an emergency, or at immediate risk of harm to yourself or others, please contact emergency services on '000'. To talk to someone now call Lifeline 13 11 14 or Suicide Call Back Service 1300 659 467.", "facebook": "", "twitter": "", "instagram": "", "beyondblue": "https://www.beyondblue.org.au/", "movember": "https://www.beyondblue.org.au/", "vac": "https://thorneharbour.org/", "acon": "http://www.acon.org.au/", "csrh": "https://csrh.arts.unsw.edu.au/", "additional": "http://www.gamma.org.au/"}, "articles": {"https://dale.liquorice.net.au/articles/face-to-face-session-monday-14th-june-at-830pm-aest/": "Face-to-face session Monday 14th June at 8:30pm AEST", "https://dale.liquorice.net.au/articles/new-ways-of-using-prep/": "New ways of using PrEP!", "https://dale.liquorice.net.au/articles/face-to-face-session-monday-17th-may-at-830pm-aest/": "Face-to-face session Monday 17th May at 8:30pm AEST", "https://dale.liquorice.net.au/articles/what-does-undetectable-mean/": "What does undetectable mean?", "https://dale.liquorice.net.au/articles/what-exactly-is-same-sex-attraction/": "What exactly is same-sex attraction?", "https://dale.liquorice.net.au/articles/four-questions-to-ask-any-guy-you-meet-online-before-you-meet-up/": "Four questions to ask any guy you meet online, before you meet up", "https://dale.liquorice.net.au/articles/what-is-bisexuality/": "What is Bisexuality?", "https://dale.liquorice.net.au/articles/whats-the-deal-with-hooking-up-right-now/": "What\u2019s the deal with hooking up right now?", "https://dale.liquorice.net.au/articles/sending-nudes-and-filming-dudes-a-guide-for-law-abiding-citizens/": "Sending nudes and filming dudes: a guide for law-abiding citizens", "https://dale.liquorice.net.au/articles/virtually-hooking-up-a-beginners-guide-to-online-sex/": "Virtually hooking up: a beginner\u2019s guide to online sex", "https://dale.liquorice.net.au/articles/toms-story/": "Tom\u2019s Story", "https://dale.liquorice.net.au/articles/sams-story/": "Sam\u2019s Story", "https://dale.liquorice.net.au/articles/dans-story/": "Dan's Story", "https://dale.liquorice.net.au/articles/tonys-story/": "Tony's Story", "https://dale.liquorice.net.au/articles/ryans-personal-story/": "Ryan's Personal Story", "https://dale.liquorice.net.au/articles/neals-story/": "Neal's Story", "https://dale.liquorice.net.au/articles/davids-story-part-eight-im-much-more-content-within-myself/": "David\u2019s Story - Part Eight: \u201cI\u2019m much more content within myself.\u201d", "https://dale.liquorice.net.au/articles/davids-story-part-seven-im-really-grateful-for-my-sexuality/": "David\u2019s Story - Part Seven: \u201cI\u2019m really grateful for my sexuality.\u201d", "https://dale.liquorice.net.au/articles/davids-story-part-five-i-pretty-well-left-the-house-as-it-was/": "David\u2019s Story - Part Five: \u201cI pretty well left the house as it was.\u201d", "https://dale.liquorice.net.au/articles/davids-story-part-four-i-thought-i-just-needed-a-heterosexual-relationship/": "David\u2019s Story - Part Four: \u201cI thought I just needed a heterosexual relationship.\u201d", "https://dale.liquorice.net.au/articles/davids-story-part-three-if-thats-how-you-are-we-still-love-you/": "David's Story - Part Three: \"If that's how you are we still love you.\"", "https://dale.liquorice.net.au/articles/davids-story-part-two-i-went-off-to-every-healing-service-i-could-find/": "David's Story - Part Two: \u201cI went off to every healing service I could find.\u201d", "https://dale.liquorice.net.au/articles/davids-story-part-one-i-think-ive-always-known-i-was-different/": "David\u2019s Story - Part One: \u201cI think I\u2019ve always known I was different.\u201d", "https://dale.liquorice.net.au/articles/we-still-love-each-other-meet-the-man-who-came-out-after-20-years-of-marriage/": "'We still love each other': meet the man who came out after 20 years of marriage", "https://dale.liquorice.net.au/articles/beat-safety/": "Beat Safety", "https://dale.liquorice.net.au/articles/coming-out-later-in-life-whats-involved-part-1-of-2/": "Coming out later in life - What's involved? (Part 1 of 2)", "https://dale.liquorice.net.au/articles/coming-out-later-in-life-whats-involved-part-2-of-2/": "Coming out later in life - What's involved? (Part 2 of 2)", "https://dale.liquorice.net.au/articles/think-youve-been-exposed-to-hiv-get-pep/": "Think you've been exposed to HIV? Get PEP!", "https://dale.liquorice.net.au/articles/safe-cruising/": "Safe Cruising", "https://dale.liquorice.net.au/articles/what-is-internalised-homophobia/": "What is Internalised Homophobia?", "https://dale.liquorice.net.au/articles/preventing-hiv/": "Preventing HIV", "https://dale.liquorice.net.au/articles/what-kind-of-treatment-is-available-for-anxiety-and-depression/": "What kind of treatment is available for Anxiety and Depression?", "https://dale.liquorice.net.au/articles/what-can-i-do-to-feel-better/": "What can I do to feel better?", "https://dale.liquorice.net.au/articles/what-is-depression/": "What is Depression?", "https://dale.liquorice.net.au/articles/what-exactly-is-anxiety/": "What exactly is Anxiety?", "https://dale.liquorice.net.au/articles/what-is-stigma/": "What is stigma?", "https://dale.liquorice.net.au/articles/face-to-face-session-monday-12th-april-at-830pm-aedt/": "Face-to-face session Monday 12th April at 8:30pm AEDT", "https://dale.liquorice.net.au/articles/face-to-face-session-monday-2nd-march-at-830pm-aedt/": "Face-to-face session Tuesday 2nd March at 8:30pm AEDT", "https://dale.liquorice.net.au/articles/face-to-face-session-monday-21st-june-at-830pm-aest/": "Face-to-face session Monday 21st June at 8:30pm AEST", "https://dale.liquorice.net.au/articles/could-we-crush-hiv-and-stis-if-we-all-got-tested-right-now/": "Could we crush HIV and STIs if we all got tested right now?", "https://dale.liquorice.net.au/articles/virtual-face-to-face-support-sessions-coming-to-dale/": "Virtual face-to-face support sessions coming to DALE!", "https://dale.liquorice.net.au/articles/davids-story-part-six-two-and-a-half-years-after-separating-i-felt-myself-sinking/": "David\u2019s Story - Part Six: \u201cTwo and a half years after separating, I felt myself sinking.\u201d"}}
  end

  def threads_for_tag
    threads = @site.topic_threads.visible.for_tag(params[:tag])
    render json: threads.map(&:export_to_json)
  end

  def threads_for_query
    threads = @site.topic_threads.visible.for_query(params[:query])
    render json: threads.map(&:export_to_json)
  end

  def sessions_for_tag
    sessions = @site.chat_sessions.where(status: [ChatSession.statuses['open'], ChatSession.statuses['scheduled']]).for_tag(params[:tag])
    render json: sessions.map(&:export_to_json)
  end

  def sessions_for_query
    sessions = @site.chat_sessions.where(status: [ChatSession.statuses['open'], ChatSession.statuses['scheduled']]).for_query(params[:query])
    render json: sessions.map(&:export_to_json)
  end

  def current_user
    if @current_user
      user_details = {
        name: @current_user.name,
        avatar_colour: @current_user.processed_avatar_colour,
        avatar_face: @current_user.avatar_face
      }
    else
      user_details = false
    end

    render json: { user: user_details }
  end

  def upcoming_chat
    @chat_sessions = @site.chat_sessions.where(status: [ChatSession.statuses['open'], ChatSession.statuses['scheduled']])
    if @chat_sessions.any?
      chat_session = @chat_sessions.first
      chat = {
        name: chat_session.name,
        description: chat_session.description,
        url: chat_session_path(chat_session),
        scheduled_for: chat_session.scheduled_for.to_i,
        starts_in: distance_of_future_time_in_words(chat_session.scheduled_for),
        status: ((chat_session.status if chat_session.open?) || ("upcoming" if (chat_session.scheduled_for <= 1.day.from_now)) || chat_session.status)
      }
    else
      chat = false;
    end

    render json: { chat: chat }
  end

  def forums_overview
    topics = []
    @site.topics.visible.first(2).each do |topic|
      threads = []
      @topic_threads = topic
          .topic_threads
          .visible
          .where(pinned: false)
          .by_activity
          .limit(2)

      @topic_threads.each do |topic_thread|
        threads.push({
          data: topic_thread.export_to_json
        })
      end

      topics.push({
        name: topic.name,
        url: topic_path(topic),
        threads: threads
      })
    end

    render json: topics
  end

  private

  def cors_set_access_control_headers
    response.headers["Access-Control-Allow-Origin"] = request.headers["origin"]
    response.headers["Access-Control-Allow-Methods"] = "GET"
    response.headers['Access-Control-Allow-Credentials'] = "true"
  end


end
