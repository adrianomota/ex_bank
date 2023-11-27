defmodule ExBank.Factory do
  use ExMachina.Ecto, repo: ExBank.Repo

  @fake_pass "123456"

  def user_contract_factory do
    %{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      email: Faker.Internet.email(),
      password: @fake_pass,
      password_confirmation: @fake_pass
    }
  end

  def user_entity_factory do
    %ExBank.Entities.User{
      first_name: Faker.Person.first_name(),
      last_name: Faker.Person.last_name(),
      email: Faker.Internet.email(),
      password: @fake_pass,
      password_confirmation: @fake_pass,
      password_hash: "asdf..."
    }
  end
end
