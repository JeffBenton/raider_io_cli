class RaiderIoCli::Dungeon
  attr_accessor :name, :nick_name, :clear_time, :score, :world_rank, :region_rank
  attr_reader :date, :level, :stars, :affixes

  DUNGEON_NAME_PAIRS = {
      :AD => "Atal'Dazar",
      :FH => "Freehold",
      :TD => "Tol Dagor",
      :UNDR => "The Underrot",
      :TOS => "Temple of Sethraliss",
      :WM => "Waycrest Manor",
      :KR => "Kings' Rest",
      :SIEGE => "Siege of Boralus",
      :ML => "The MOTHERLODE!!",
      :SOTS => "Shrine of the Storm"
  }

  DUNGEON_AFFIXES = {
      2 => "Skittish",
      3 => "Volcanic",
      4 => "Necrotic",
      5 => "Teeming",
      6 => "Raging",
      7 => "Bolstering",
      8 => "Sanguine",
      9 => "Tyrannical",
      10 => "Fortified",
      11 => "Bursting",
      12 => "Grievous",
      13 => "Explosive",
      14 => "Quaking",
      117 => "Reaping"
  }

  def initialize(name:, nick_name:, date:, level:, stars:)
    if !name
      @name = DUNGEON_NAME_PAIRS[nick_name.to_sym]
      @nick_name = nick_name
    else
      @name = name
      @nick_name = DUNGEON_NAME_PAIRS.key(name).to_s
    end
    @date = date
    @level = level
    @stars = stars
    @affixes = []
  end

  def add_affixes(affixes)
    affixes.each { |affix| @affixes << DUNGEON_AFFIXES[affix.to_i] }
  end

  def self.list_dungeons
    DUNGEON_NAME_PAIRS.each_pair { |abrev, dungeon| puts "#{dungeon} (#{abrev.to_s})" }
  end
end