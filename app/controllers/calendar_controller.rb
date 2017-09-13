class CalendarController < ApplicationController

  respond_to :json
  def index


  end

  def get_events

    @task = Event.all
    events = []
    @task.each do |task|
      events << {:id => task.id, :title => "#{task.name}", :start => "#{task.start_date.rfc822}",:end => "#{task.end_date.rfc822}" }
    end
    render :text => events.to_json
  end
end
