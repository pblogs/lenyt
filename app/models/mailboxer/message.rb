class Mailboxer::Message < Mailboxer::Notification
  attr_accessible :attachment if Mailboxer.protected_attributes?
  self.table_name = :mailboxer_notifications

  belongs_to :conversation, :class_name => "Mailboxer::Conversation", :validate => true, :autosave => true
  validates_presence_of :sender

  class_attribute :on_deliver_callback

  after_create :publish_messages

  def publish_messages
    recipients = self.recipients.delete(self.sender)
    recipient = conv.participants.first


      Socket.send('message', {
      recipient_id: recipient.id,
      recipient_name: recipient.full_name,
      sender_id: message.sender_id,
      sender_name: message.sender.full_name,
      body: message.body,
      created_at: message.created_at,
      id: message.id
    }.to_json )
  end

  protected :on_deliver_callback
  scope :conversation, lambda { |conversation|
    where(:conversation_id => conversation.id)
  }

  mount_uploader :attachment, AttachmentUploader

  class << self
    #Sets the on deliver callback method.
    def on_deliver(callback_method)
      self.on_deliver_callback = callback_method
    end
  end

  #Delivers a Message. USE NOT RECOMENDED.
  #Use Mailboxer::Models::Message.send_message instead.
  def deliver(reply = false, should_clean = true)
    self.clean if should_clean

    #Receiver receipts
    temp_receipts = recipients.map { |r| build_receipt(r, 'inbox') }

    #Sender receipt
    sender_receipt = build_receipt(sender, 'sentbox', true)

    temp_receipts << sender_receipt

    if temp_receipts.all?(&:valid?)
      temp_receipts.each(&:save!)
      Mailboxer::MailDispatcher.new(self, recipients).call

      conversation.touch if reply

      self.recipients = nil

      on_deliver_callback.call(self) if on_deliver_callback
    end
    sender_receipt
  end
end
