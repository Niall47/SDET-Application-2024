# frozen_string_literal: true

require 'validator'

describe Validator do
  describe 'first_name' do
    # -	Optional
    # -	If present, must contain at least one alphabetic character
    # -	Following special characters are allowed:
    #                                       o	Hyphen
    #                                       o	Apostrophe
    # -	A person may have multiple first names
    it 'should allow a valid name' do
      first_name = 'Niall'
      expect(Validator.first_name(first_name)).to be true
    end
    it 'should allow a blank name' do
      first_name = ''
      expect(Validator.first_name(first_name)).to be true
    end
    it 'should allow multiple first names' do
      first_name = 'Jimmy Joe'
      expect(Validator.first_name(first_name)).to be true
    end
    it 'should allow hyphenated first names' do
      first_name = 'Jimmy-joe'
      expect(Validator.first_name(first_name)).to be true
    end
    it 'should allow multiple hyphenated first names' do
      first_name = "Jimmy-joe O'Hearn"
      expect(Validator.first_name(first_name)).to be true
    end
    it 'should allow apostrophes in first names' do
      first_name = "Jimmy O'Hearn"
      expect(Validator.first_name(first_name)).to be true
    end
    it 'should not allow a name without any alphabetic character' do
      first_name = '47'
      expect(Validator.first_name(first_name)).to be false
    end
  end
  describe 'last_name' do
    # -	Mandatory
    # -	Must contain at least one alphabetic character
    # -	Following special characters are allowed:
    #                                       o	Hyphen
    #                                       o	Apostrophe
    # -	A person may have multiple last names
    it 'should allow a valid name' do
      last_name = 'Niall'
      expect(Validator.last_name(last_name)).to be true
    end
    it 'should allow a blank name' do
      last_name = ''
      expect(Validator.last_name(last_name)).to be true
    end
    it 'should allow multiple last names' do
      last_name = 'Jimmy Joe'
      expect(Validator.last_name(last_name)).to be true
    end
    it 'should allow hyphenated last names' do
      last_name = 'Jimmy-joe'
      expect(Validator.last_name(last_name)).to be true
    end
    it 'should allow multiple hyphenated last names' do
      last_name = "Jimmy-joe O'Hearn"
      expect(Validator.last_name(last_name)).to be true
    end
    it 'should allow apostrophes in last names' do
      last_name = "Jimmy O'Hearn"
      expect(Validator.last_name(last_name)).to be true
    end
    it 'should not allow a name without any alphabetic character' do
      last_name = '47'
      expect(Validator.last_name(last_name)).to be false
    end
  end
  describe 'date_of_birth' do
    # -	Mandatory
    # -	Day and Month can either be zero-padded or not
    # -	Year must include century
    # -	A person cannot be older than 100 years
    # -	A person cannot be younger than 15 years
    # -	Date must not be in the future
    it 'should allow a valid date of birth' do
      expect(Validator.date_of_birth '1994-02-05').to be true
    end
    it 'should not allow a blank date of birth' do
      expect(Validator.date_of_birth('')).to be false
    end
    it 'should not allow a date of birth missing the century' do
      expect(Validator.date_of_birth('94-02-05')).to be false
    end
    it 'should not allow a date of birth in the future' do
      expect(Validator.date_of_birth('2030-02-05')).to be false
    end
    it 'should not allow a date of birth older than 100 years' do
      expect(Validator.date_of_birth('1919-02-05')).to be false
    end
    it 'should not allow a date of birth younger than 15 years' do
      expect(Validator.date_of_birth('2020-02-05')).to be false
    end
  end
end