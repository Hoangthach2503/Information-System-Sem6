require 'gsl'
require 'matrix'
require 'numo/narray'

def brain_factorization(data, K, step=5000, beta=0.002, lambada=0.02)
    W = Numo::DFloat.new((data.count,K).rand
    H = Numo::DFloat.new((data.first.count,K).rand

    H = H.to_a.tranpose

    def Avg(user)
        sodanhgia = 0
        ru = 0
        $input.first.count.times do |i|
          if $input[user][i] != 0
            sodanhgia+= 1
            ru += $input[user][i]
          end
        end
          ru /= sodanhgia
          return ru
      end
    biasI = Numo::DFloat.new((0))
    biasU = Numo::DFloat.new([1],(0))

    data.length.times do |i|
        if(data[i+1][0].!include[0].to_a.count == 0)
            biasI[i] = 0
        else
            biasI[i] = Avg(data[i][data[i+1].!include[0]])
        end
    end
    data.tranpose.length.times do |i|
        if((data.tranpose[i].!include[0])[0]) == 0)
                biasU[i] = 0
        else
            biasU[i] = Avg(data.tranpose[i][data.tranpose[i].!include[0]])
        end
    end
    b = Avg(data[!include[0]])

    step.times do |step|
        data.count.times do |i|
            data.first.count.times do |j|
                if data[i][j] > 0
                    p_bar = b + biasI[i] + biasU[j] + (W[i][-1].inner_product(H[:-1][j])
                    eij = data[i][j] - p_bar

                    b = b + beta * eij

                    biasI[i] += beta * (eij - lambada * biasI[i])
                    biasU[j] += beta * (eij - lambada * biasU[j])
                    W[i][-1] += beta*(2*eij*H[-1][j] - lambada * W[i][:-1])
                    H[-1][j] += beta*(2*eij*W[i][-1] - lambada * H[-1][j])
                end
            end
        end
    end
    e_data = W.inner_product(H)
    e = 0
    data.count.times do |i|
        data.first.count.times do |j|
            if data[i][j] > 0 
                e = e + (data[i][j] - (W[i][-1].inner_product(H[-1][j]))) **2 
                    K.times do |k|
                        e = e + (lambada/2) * ( (W[i][k]) ** 2 + (H[k][j]) ** 2)
                    end
                end
            end
        end
    end
    if e < 0.001:
        print("Epsilon's exit")
        break
    end
return W, H.tranpose, biasI, biasU, b
end
counter = 1
begin
    file = File.new("/home/ledsinh/gg.txt", "r")
    while (line = file.gets)
        puts "#{counter}: #{line}"
        counter = counter + 1
    end
    file.close
rescue => err
    puts "Exception: #{err}"
    err
end

data = Numo::DFloat(data)
print(data)
K = 2

W,H,b_u,b_i,b = matrix_factorization(data, K)
print("Matrix Factorization with Bias")
fitted = b + W.inner_product(H.tranpose) + biasI[-1][np.newaxis] + biasU[np.newaxis][-1]

for i in fitted:
    puts i.round(2)
end



