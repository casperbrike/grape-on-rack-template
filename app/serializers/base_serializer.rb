class BaseSerializer

  def initialize(object)
    @object = object
  end

  def to_json(opts = {})
    as_json.to_json
  end

  def as_json(opts = {})
    if @object.is_a? Array
      @object.map { |e| self.class.new(e).to_h }
    else
      to_h
    end
  end

end
