require 'action_mailer'
require 'active_support'

require 'test_helper'

class MyTestMailer < ActionMailer::Base
  default from: "from@example.com", to: "to@example.com", subject: "Subject"

  def multipart(body, options = {})
    mail options do |format|
      format.html { render plain: "<p>#{body}</p>" }
      format.text { render plain: body }
    end
  end
end

class MailAssertionsTest < Minitest::Test
  include MailAssertions

  def setup
    super
    ActionMailer::Base.deliveries.clear
    @mail = MyTestMailer.multipart("Body").deliver
  end

  def test_mail_with_condition_returns_all_matching_emails
    another_mail = MyTestMailer.multipart("More body", to: "also@example.com").deliver
    assert_equal [@mail, another_mail], list_with_conditions(ActionMailer::Base.deliveries, from: ["from@example.com"])
  end

  def test_assert_mail_works_if_one_email_matches
    assert_mail subject: 'Subject'
  end

  def test_assert_mail_fails_if_zero_emails_match
    assert_raises Minitest::Assertion do
      assert_mail subject: 'Wrong subject'
    end
  end

  def test_assert_mail_fails_if_more_than_one_email_matches
    MyTestMailer.multipart("More body", to: "also@example.com").deliver
    assert_raises Minitest::Assertion do
      assert_mail from: ["from@example.com"]
    end
  end

  def test_assert_mail_block_can_take_mail_as_argument
    assert_mail subject: 'Subject' do |mail|
      assert_equal 'to@example.com', mail.to[0]
    end
  end

  def test_assert_mail_block_can_take_mail_and_html_body_as_argument
    assert_mail subject: 'Subject' do |mail, body|
      assert_equal "<p>Body</p>", body
    end
  end

  def test_refute_mail_raises_if_a_matching_email_is_found
    assert_raises Minitest::Assertion do
      refute_mail subject: 'Subject'
    end
  end

  def test_refute_mail_works_if_no_matching_email_is_found
    refute_mail subject: 'Wrong subject'
  end
end
