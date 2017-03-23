require 'action_mailer'
require 'active_support'

module MailAssertions
  def assert_mail(conditions = {}, &block)
    emails = list_with_conditions(ActionMailer::Base.deliveries, conditions)
    unless emails.count == 1
      all_subjects = ActionMailer::Base.deliveries.map(&:subject)
      if emails.count == 0
        assert false, "The mail '#{conditions}' was not sent: <#{all_subjects.join(', ')}>"
      else
        assert false, "More than one mail '#{conditions}' was sent: <#{all_subjects.join(', ')}>"
      end
    end
    mail = emails.first
    if block_given?
      case block.arity
        when 2
          yield mail, mail.html_part.body.to_s
        else
          yield mail
      end
    end
  end

  def refute_mail(conditions = {})
    assert_empty list_with_conditions(ActionMailer::Base.deliveries, conditions)
  end

  private

  def list_with_conditions(list, conditions)
    raise ArgumentError.new("specify at least one condition") if conditions.blank?
    list.select do |item|
      conditions.map do |name, value|
        if value.kind_of? Regexp
          item.send(name) =~ value
        else
          item.send(name) == value
        end
      end.all?
    end
  end
end
