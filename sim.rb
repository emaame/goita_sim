class SHI  ; def to_s; "し"; end; def to_i; 0x11; end; end
class GON  ; def to_s; "香"; end; def to_i; 0x21; end; end
class GIN  ; def to_s; "金"; end; def to_i; 0x31; end; end
class KIN  ; def to_s; "銀"; end; def to_i; 0x32; end; end
class BAKKO; def to_s; "馬"; end; def to_i; 0x33; end; end
class KAKU ; def to_s; "角"; end; def to_i; 0x41; end; end
class HI   ; def to_s; "飛"; end; def to_i; 0x42; end; end
class OU   ; def to_s; "王"; end; def to_i; 0x51; end; end

TIMES = 10000000

def main
	yama = Array.new(10, SHI.new)
	yama.concat Array.new( 4, GON.new)
	yama.concat Array.new( 4, GIN.new)
	yama.concat Array.new( 4, KIN.new)
	yama.concat Array.new( 4, BAKKO.new)
	yama.concat Array.new( 2, KAKU.new)
	yama.concat Array.new( 2, HI.new)
	yama.concat Array.new( 2, OU.new)

	goshi = rokushi = nanashi = hasshi = goshigoshi = nigon = sanngon = yonngon = 0
	yonshi_sanshi = yonshi_yonshi = yonshi = 0 

	damadama = 0

	TIMES.times do
#	100.times do
		yama.shuffle!
		hand1 = yama[ 0,8]#.sort_by{|o|o.to_i}
		hand2 = yama[ 8,8]#.sort_by{|o|o.to_i}
		hand3 = yama[16,8]#.sort_by{|o|o.to_i}
		hand4 = yama[24,8]#.sort_by{|o|o.to_i}

=begin
		puts hand1.map{|o|o.to_s}.join
		puts hand2.map{|o|o.to_s}.join
		puts hand3.map{|o|o.to_s}.join
		puts hand4.map{|o|o.to_s}.join
=end

		# ダマダマは発生する確率が欲しいので全部で調べる
		ou_counts = [
			hand1.count{|o|o.class == OU},
			hand2.count{|o|o.class == OU}, 
			hand3.count{|o|o.class == OU},
			hand4.count{|o|o.class == OU}
		]
		ou_counts.each do |ou_count|
			damadama += 1 if ou_count == 2
		end

		# しは５し５しが有るのでペアで調べないといけない 
		shi_counts = [
			[
				hand1.count{|o|o.class == SHI},
				hand2.count{|o|o.class == SHI}
			],
			[
				hand3.count{|o|o.class == SHI},
				hand4.count{|o|o.class == SHI}
			]
		]

		shi_counts.each do |shi_count1, shi_count2|
			case shi_count1
			when 4
				yonshi += 1
				if shi_count2 == 3
					yonshi_sanshi += 1
				elsif shi_count2 == 4
					yonshi_yonshi += 1
				end
			when 5
				if shi_count2 == 5
					goshigoshi += 1
				else
					goshi += 1
				end
			when 6 then rokushi += 1
			when 7 then nanashi += 1
			when 8 then hasshi  += 1
			end
	
			case shi_count2
			when 5
				goshi += 1 if shi_count1 != 5 # ５し５しのときはカウントしない
			when 6 then rokushi += 1
			when 7 then nanashi += 1
			when 8 then hasshi  += 1
			end
		end

		# 香は自分の手札に来る確率を求めたいので、自分の手札だけみる
		gon_count  = hand1.count{|o|o.class == GON}
		case gon_count
		when 2 then nigon += 1
		when 3 then sanngon += 1
		when 4 then yonngon += 1
		end
	end

	puts "だまだま：#{damadama}…#{damadama*100.0/TIMES} %"
	puts "五し：#{goshi  }…#{goshi  *100.0/TIMES} %"
	puts "六し：#{rokushi}…#{rokushi*100.0/TIMES} %"
	puts "七し：#{nanashi}…#{nanashi*100.0/TIMES} %"
	puts "八し：#{hasshi }…#{hasshi *100.0/TIMES} %"
	puts "五し五し：#{goshigoshi}…#{goshigoshi*100.0/TIMES} %"
	puts "二香：#{nigon}…#{nigon*100.0/TIMES} %"
	puts "三香：#{sanngon}…#{sanngon*100.0/TIMES} %"
	puts "四香：#{yonngon}…#{yonngon*100.0/TIMES} %"

	puts "四し三し：#{yonshi_sanshi}…#{yonshi_sanshi*100.0/yonshi} %"
	puts "四し四し：#{yonshi_yonshi}…#{yonshi_yonshi*100.0/yonshi} %"
end

main


