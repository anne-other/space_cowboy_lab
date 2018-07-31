require("pg")


class Bounty

  attr_reader :id
  attr_accessor :name, :danger_level, :favourite_weapon, :bounty_level

  def initialize(options)
    @id = options['id'].to_i() if options['id']
    @name = options['name']
    @danger_level = options['danger_level']
    @favourite_weapon = options['favourite_weapon']
    @bounty_level = options['bounty_level'].to_i()
  end

  def save()
    db = PG.connect({dbname: "space_cowboy", host: "localhost"})
    sql = "INSERT INTO bounties
          (name, danger_level, favourite_weapon, bounty_level)
          VALUES ($1, $2, $3, $4) RETURNING id"
    values = [@name, @danger_level, @favourite_weapon, @bounty_level]
    db.prepare("save", sql)
    result = db.exec_prepared("save", values)
    @id = result[0]['id'].to_i()
    db.close()
  end

  def update()
    db = PG.connect({dbname: "space_cowboy", host: "localhost"})
    sql = "UPDATE bounties SET
      (name, danger_level, favourite_weapon, bounty_level) = ($1, $2, $3, $4) WHERE id = $5"
    values = [@name, @danger_level, @favourite_weapon, @bounty_level, @id]
    db.prepare("update", sql)
    result = db.exec_prepared("update", values)
    db.close()
  end

  def delete_one()
    db = PG.connect({dbname: "space_cowboy", host: "localhost"})
    sql = "DELETE FROM bounties WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def Bounty.find_by_name(name)
    db = PG.connect({dbname: "space_cowboy", host: "localhost"})
    sql = "SELECT * FROM bounties WHERE name = $1"
    values = [name]
    db.prepare("find_by_name", sql)
    result = db.exec_prepared("find_by_name", values)
    db.close()
    return Bounty.new(result[0])
  end

end
