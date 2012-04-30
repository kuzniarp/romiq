# -*- coding: utf-8 -*-
class Mailer < ActionMailer::Base  
  MAIL_DOMAIN = 'frinet.home.pl'
  RECIPIENTS = {"1" => "biuro@#{MAIL_DOMAIN}", "2" => "krzysztof@#{MAIL_DOMAIN}", "3" => "mirek@#{MAIL_DOMAIN}", "4" => "mirek@#{MAIL_DOMAIN}"}

  def mail subject, email, message, branch, sent_at = Time.now
    @subject    = subject
    @body       = {:message => message}
    @recipients = RAILS_ENV == 'production' ? RECIPIENTS[branch] : 'kuzniarp@gmail.com'
    @from       = email
    @sent_on    = sent_at
    @content_type = 'text/html'    
  end
end
