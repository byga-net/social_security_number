module CivilNumber
  class Ch < Country
    def validate
      @error = if !check_digits
                 'it is not number'
               elsif !check_by_regexp(REGEXP)
                 'bad number format'
               elsif !birth_date
                 'number birth date is invalid'
               elsif !check_control_sum
                 'number control sum invalid'
      end
    end

    private

    MODULUS = 11

    CONTROLCIPHERS = [7, 9, 10, 5, 8, 4, 2, 1, 6, 3, 7, 9, 10, 5, 8, 4, 2, 1].freeze

    REGEXP = /^(?<adress>\d{6})[- .]?(?<year>\d{4})[- .]?(?<month>\d{2})[- .]?(?<day>\d{2})[- .]?(?<individual>\d{3})[- .]?(?<control>\d{1})$/

    def check_control_sum
      count_last_number == @control_number
    end

    def count_last_number
      (12 - (calc_sum(@civil_number[0..16], CONTROLCIPHERS) % MODULUS)) % MODULUS
    end

    def base_year(year)
      year[:year].to_i
    end

    def gender_from_number
      @individual.odd? ? :male : :female
    end
  end
end
