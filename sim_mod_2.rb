class SHI  ; def to_s; "し"; end; def to_i; 0x11; end; end
class GON  ; def to_s; "香"; end; def to_i; 0x21; end; end
class GIN  ; def to_s; "銀"; end; def to_i; 0x31; end; end
class KIN  ; def to_s; "金"; end; def to_i; 0x32; end; end
class BAKKO; def to_s; "馬"; end; def to_i; 0x33; end; end
class KAKU ; def to_s; "角"; end; def to_i; 0x41; end; end
class HI   ; def to_s; "飛"; end; def to_i; 0x42; end; end
class OU   ; def to_s; "王"; end; def to_i; 0x51; end; end

TIMES = 1000000

def main
	yama = Array.new(10-5-3, SHI.new)
	yama.concat Array.new( 4-3, GON.new)
	yama.concat Array.new( 4-2, GIN.new)
	yama.concat Array.new( 4-1, KIN.new)
	yama.concat Array.new( 4-1, BAKKO.new)
	yama.concat Array.new( 2-0, KAKU.new)
	yama.concat Array.new( 2-0, HI.new)
	yama.concat Array.new( 2-1, OU.new)

	shi_mochi_count = 0
	ou_mochi_count = 0
	gin_mochi_count = 0
	gin_or_ou_mochi_count = 0

	hand1 = [SHI.new,SHI.new,SHI.new,BAKKO.new,GIN.new,GIN.new,KIN.new,OU.new]
	hand2_sangon = [GON.new,GON.new,GON.new]
	hand4_goshi = [SHI.new,SHI.new,SHI.new,SHI.new,SHI.new]
	TIMES.times do
#	5.times do
		# hand4 を5しに調整する
		loop do
			yama.shuffle!
			break unless yama[13,3].find{|o|o.class == SHI} # しがあったら駄目なのでりシャッフル
		end
		hand1 = hand1
		hand2 = yama[ 0,5].concat(hand2_sangon) # 3香を加える
		hand3 = yama[ 5,8]
		hand4 = yama[13,3].concat(hand4_goshi) # 5しを加える

		unless hand2.count{|o|o.class == GON} >=3
			warn "P2が3香以上じゃない : " + hand2.sort_by{|o|o.to_i}.map{|o|o.to_s}.join
		end
		unless hand4.count{|o|o.class == SHI} == 5
			warn "P4が5しじゃない : " + hand4.sort_by{|o|o.to_i}.map{|o|o.to_s}.join
		end

=begin
		if 1
			hand1 = hand1.sort_by{|o|o.to_i}
			hand2 = hand2.sort_by{|o|o.to_i}
			hand3 = hand3.sort_by{|o|o.to_i}
			hand4 = hand4.sort_by{|o|o.to_i}

			puts "P1: " + hand1.map{|o|o.to_s}.join
			puts "P2: " + hand2.map{|o|o.to_s}.join
			puts "P3: " + hand3.map{|o|o.to_s}.join
			puts "P4: " + hand4.map{|o|o.to_s}.join
			puts ""
		end
=end

		has_gin = hand2.find{|o|o.class == GIN}
		has_ou  = hand2.find{|o|o.class == OU}

		shi_mochi_count += 1 if hand2.find{|o|o.class == SHI}
		gin_mochi_count += 1 if has_gin
		 ou_mochi_count += 1 if has_ou
		gin_or_ou_mochi_count += 1 if has_gin || has_ou
	end

	puts "し持ち：#{shi_mochi_count}…#{shi_mochi_count*100.0/TIMES} %"
	puts "銀/王持ち：#{gin_or_ou_mochi_count}…#{gin_or_ou_mochi_count*100.0/TIMES} %"
	puts "銀持ち：#{gin_mochi_count}…#{gin_mochi_count*100.0/TIMES} %"
	puts "王持ち：#{ ou_mochi_count}…#{ou_mochi_count*100.0/TIMES} %"
end

main


