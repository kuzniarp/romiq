# -*- coding: utf-8 -*-
class Mailer < ActionMailer::Base  
  RECIPIENTS = {"1" => "biuro@romiq.pl", "2" => "krzysztof@romiq.pl", "3" => "mirek@romiq.pl", "4" => "mirek@romiq.pl"}

  def mail subject, email, message, branch, sent_at = Time.now
    @subject    = subject
    @body       = {:message => message}
    @recipients = RAILS_ENV == 'production' ? RECIPIENTS[branch] : 'kuzniarp@gmail.com'
    @from       = email
    @sent_on    = sent_at
    @content_type = 'text/html'    
  end
end
