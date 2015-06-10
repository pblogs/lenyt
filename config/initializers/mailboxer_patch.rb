module Mailboxer
  module Models
    module Messageable
      def send_message(
        recipients, msg_body,
        subject, request_id = nil,
        sanitize_text = true, attachment = nil,
        message_timestamp = Time.now)
        convo = Mailboxer::ConversationBuilder.new({
          subject: subject,
          created_at: message_timestamp,
          updated_at: message_timestamp,
          request_id: request_id
        }).build

        message = Mailboxer::MessageBuilder.new({
          sender: self,
          conversation: convo,
          recipients: recipients,
          body: msg_body,
          subject: subject,
          attachment: attachment,
          created_at: message_timestamp,
          updated_at: message_timestamp
        }).build

        message.deliver false, sanitize_text
      end
    end
  end
end
