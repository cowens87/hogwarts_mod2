require 'rails_helper'

RSpec.describe Professor, type: :model do
  before(:each) do
    @snape = Professor.create(name: "Severus Snape", age: 45, specialty: "Potions")
    @hagarid = Professor.create(name: "Rubeus Hagrid", age: 38 , specialty: "Care of Magical Creatures")
    @lupin = Professor.create(name: "Remus Lupin", age: 49 , specialty: "Defense Against The Dark Arts")

    @harry = Student.create(name: "Harry Potter" , age: 11 , house: "Gryffindor" )
    @malfoy = Student.create(name: "Draco Malfoy" , age: 12 , house: "Slytherin" )
    @longbottom = Student.create(name: "Neville Longbottom" , age: 11 , house: "Gryffindor" )

    ProfessorStudent.create(student_id: @harry.id, professor_id: @snape.id)
    ProfessorStudent.create(student_id: @harry.id, professor_id: @hagarid.id)
    ProfessorStudent.create(student_id: @harry.id, professor_id: @lupin.id)
    ProfessorStudent.create(student_id: @malfoy.id, professor_id: @hagarid.id)
    ProfessorStudent.create(student_id: @malfoy.id, professor_id: @lupin.id)
    ProfessorStudent.create(student_id: @longbottom.id, professor_id: @snape.id)
  end

  describe 'validations' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :age}
    it {should validate_presence_of :specialty}
  end

  describe 'relationships' do
    it {should have_many :professor_students}
    it {should have_many(:students).through(:professor_students)}
  end
  # User Story 2
  it 'Can list the names of professors students' do
    expect(@snape.student_names).to eq(['Harry Potter', 'Neville Longbottom'])
    expect(@lupin.student_names).to eq(['Harry Potter', 'Draco Malfoy'])
  end
  # User Story 4
  it 'Knows the average age' do
    expect(@snape.student_average_age).to eq(11)   
    expect(@hagarid.student_average_age).to eq(12)   
  end
  # Extension 
  it 'Lists info alphabetically (by name)'  do
    expect(Professor.alpha_order.pluck(:name)).to eq(['Remus Lupin', 'Rubeus Hagrid', 'Severus Snape'])   
  end
end
