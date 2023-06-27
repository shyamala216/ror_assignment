class RecordMailer < ApplicationMailer
  def notify_created(data)
    @record = params[:data]

    mail(to: "shm216lv.business@gmail.com", subject: "You got a new record!")
  end

  def notify_updated(data)

    mail(to: "shm216lv.business@gmail.com", subject: "You got a new record updated!")


  end
end
