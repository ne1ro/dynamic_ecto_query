defmodule Factory do
  use ExMachina.Ecto, repo: Repo

  def user_factory, do: %User{
    nickname: Faker.Pokemon.name,
    name: Faker.Superhero.name,
    password_hash: Faker.Internet.slug,
    gender: Faker.Pokemon.name,
    relationships_status: Faker.Company.buzzword,
    proficiency: Faker.Company.bullshit
  }
end
