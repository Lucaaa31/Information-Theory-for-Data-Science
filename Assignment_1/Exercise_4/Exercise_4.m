x   = [10 11 25 100];
mus = [15 25 33];
names = {'C++','Rust','Go','Python'};
max_range = 1;          

syms beta
figure;
for k = 1:3
    mu = mus(k);
    eqn = ( sum(x.*exp(-beta*x))/sum(exp(-beta*x)) - mu ) == 0;
    beta_sol = vpasolve(eqn, beta, [0 max_range]);

    if isempty(beta_sol) || double(beta_sol) <= 0
        error('Nessuna soluzione ammissibile (beta > 0) per mu = %g', mu);
    end
    beta_sol = double(beta_sol);

    p = exp(-beta_sol*x); p = p/sum(p);
    H = -sum(p.*log(p));
    fprintf('mu=%g  beta=%.5f  H=%.4f\n', mu, beta_sol, H);

    subplot(1,3,k); bar(categorical(names,names), p);
    title(sprintf('\\mu=%g, \\beta=%.4f, H=%.3f', mu, beta_sol, H));
    ylabel('p_i'); ylim([0 0.5]);
end