require("pry")
require_relative("models/space_cowboy.rb")

cowboy1 = Bounty.new({
  'name' => "Han_Solo",
  'danger_level' => "Medium",
  'favourite_weapon' => "Blaster",
  'bounty_level' => "100"
  })

  cowboy2 = Bounty.new({
    'name' => "Harry Mud",
    'danger_level' => "low",
    'favourite_weapon' => "Phaser",
    'bounty_level' => "1000"
    })

    cowboy1.save()

    binding.pry
    nil
