module SyslogRuby
  module LookupFromConst
    def self.extended(base)
      dst = {}

      base.constants.each do |pri|
        cval = base.const_get pri

        dst[pri] = cval
        dst[pri.downcase] = cval

        dst[:"LOG_#{pri.to_s}"] = cval
        dst[:"LOG_#{pri.downcase.to_s}"] = cval
        base.const_set :"LOG_#{pri.to_s}", cval

        dst[pri.to_s] = cval
        dst[pri.downcase.to_s] = cval

        dst[cval] = cval
      end

      base.define_singleton_method :keys do
        dst.keys
      end

      base.define_singleton_method :[] do |key|
        value_none = const_get :NONE
        dst.fetch(key, value_none)
      end

      base.define_singleton_method :[]= do |key, value|
        raise RuntimeError.new "#{self.class} is read only"
      end
    end
  end
end
