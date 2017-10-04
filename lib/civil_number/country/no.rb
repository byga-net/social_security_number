module CivilNumber
    class No < Country

      def validate
        @error = if !check_by_regexp(REGEXP)
          'bad number format'
        elsif !check_date
          'number birth date is invalid'
        elsif !check_control_digit_1
          'first control code invalid'
        elsif !check_control_digit_2
          'second control code invalid'
        end
      end

      private

      MODULUS = 11

      CONTROLCIPHERS_1 = [3, 7, 6, 1, 8, 9, 4, 5, 2].freeze
      CONTROLCIPHERS_2 = [5, 4, 3, 2, 7, 6, 5, 4, 3, 2].freeze

      REGEXP = /^(?<day>\d{2})(?<month>\d{2})(?<year>\d{2})(?<divider>[\-\+]{0,1})(?<individual>\d{2})(?<gender>\d{1})(?<control>\d{2})$/

      def check_date
        unless @civil_number =~ /\A(\d\d)(\d\d)(\d\d)/
          return false
        end
        if $1.to_i > 40
          day = $1.to_i - 40
        else
          day = $1.to_i
        end
        Date.valid_civil?($3.to_i, $2.to_i, day)
      end

      def check_control_digit_1
        ctrl = 11 - calc_sum(number[0, 9], CONTROLCIPHERS_1) % MODULUS
        (ctrl % MODULUS).to_s == @civil_number[-2]
      end

      def check_control_digit_2
        ctrl = 11 - calc_sum(number[0, 10], CONTROLCIPHERS_2) % MODULUS
        (ctrl % MODULUS).to_s == @civil_number[-1]
      end

      def base_year(year)
        base = case (year[:individual_number].to_i*10+year[:gender]).to_i
        when 000..499 then 1900
        when 500..899 then year[:year].to_i >= 54 ? 1800 : 2000
        when 900..999 then year[:year].to_i >= 40 ? 1900 : 2000
        else
          0
        end
        base + year[:year].to_i
      end

      def get_gender(code)
        code.odd? ? :male : :female
      end

      def number
        @civil_number.to_s.gsub(/\D/, '')
      end
  end
end