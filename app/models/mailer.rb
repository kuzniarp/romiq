# -*- coding: utf-8 -*-
class Mailer < ActionMailer::Base  
  RECIPIENTS = {"Administracja" => "biuro@romiq.pl", "Fronty Meblowe" => "krzysztof@romiq.pl", "Obsługa Klienta Indywidualnego" => "mirek@romiq.pl", "Obsługa Firm" => "mirek@romiq.pl"}

  def mail subject, email, message, branch, sent_at = Time.now
    @subject    = subject
    @body       = {:message => message}
    @recipients = RAILS_ENV == 'production' ? RECIPIENTS[branch] : 'kuzniarp@gmail.com'
    @from       = email
    @sent_on    = sent_at
    @content_type = 'text/html'    
  end
end
