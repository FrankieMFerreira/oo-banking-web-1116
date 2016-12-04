class Transfer

  attr_accessor :sender, :receiver, :amount, :status


  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @counter = 0
  end

  def valid?
    @sender.valid? && @receiver.valid?
  end

  def execute_transaction
    if valid? && @status == "pending" && self.sender.balance >= @amount
      self.sender.withdraw(@amount)
      self.receiver.deposit(@amount)
      @status = "complete"
      @counter += 1
    else
      @status = "rejected"
      "Transaction rejected. Please check your account balance."
    end
  end

  def reverse_transfer
    if @counter == 1
      self.sender.deposit(@amount)
      self.receiver.withdraw(@amount)
      @status = "reversed"
    end

  end

end
