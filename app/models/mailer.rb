class Mailer < ActionMailer::Base  
  def mail subject, email, message, sent_at = Time.now
    @subject    = subject
    @body       = {:message => message}
    @recipients = "kuzniarp@gmail.com"
    @from       = email
    @sent_on    = sent_at
    @content_type = 'text/html'    
  end
end
