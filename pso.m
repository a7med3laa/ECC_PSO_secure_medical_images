function [x]=pso(InputImage)

%% Problem Definition

CostFunction=@(x,InputImage) Pso_Fitness(x,InputImage);        % Cost Function

nVar=1;            % Number of Decision Variables

VarSize=[1 nVar];   % Size of Decision Variables Matrix

VarMin=1;         % Lower Bound of Variables
VarMax= 2000;         % Upper Bound of Variables


%% PSO Parameters

MaxIt=10;      % Maximum Number of Iterations

nPop=20;        % Population Size (Swarm Size)

% PSO Parameters
w=1;            % Inertia Weight
c1=2.0;         % Personal Learning Coefficient
c2=2.0;         % Global Learning Coefficient

% Velocity Limits
VelMax=(VarMax-VarMin);
VelMin=-VelMax;

%% Initialization

empty_particle.Position=[];
empty_particle.Cost=[];
empty_particle.Velocity=[];
empty_particle.Best.Position=[];
empty_particle.Best.Cost=[];

particle=repmat(empty_particle,nPop,1);

%Maximization
GlobalBest.Cost=-inf;

for i=1:nPop
    
    % Initialize Position
    particle(i).Position=randi([VarMin VarMax],VarSize);
    
    % Initialize Velocity
    particle(i).Velocity=zeros(VarSize);
    
    % Evaluation
    particle(i).Cost=CostFunction(particle(i).Position,InputImage);
    
    % Update Personal Best
    particle(i).Best.Position=particle(i).Position;
    particle(i).Best.Cost=particle(i).Cost;
    
    % Update Global Best
    if particle(i).Best.Cost>GlobalBest.Cost
        
        GlobalBest=particle(i).Best;
        
    end
    
end

BestCost=zeros(MaxIt,1);

%% PSO Main Loop

for it=1:MaxIt
    
    for i=1:nPop
        
        % Update Velocity
         particle(i).Velocity=round( w*particle(i).Velocity ...
            +c1*rand(VarSize).*(particle(i).Best.Position-particle(i).Position) ...
            +c2*rand(VarSize).*(GlobalBest.Position-particle(i).Position));
        
         
        % Apply Velocity Limits
        particle(i).Velocity = max(particle(i).Velocity,VelMin);
        particle(i).Velocity = min(particle(i).Velocity,VelMax);
        
        % Update Position
        particle(i).Position = particle(i).Position + particle(i).Velocity;
        
        % Velocity Mirror Effect
        IsOutside=(particle(i).Position<VarMin | particle(i).Position>VarMax);
        particle(i).Velocity(IsOutside)=-particle(i).Velocity(IsOutside);
        
        % Apply Position Limits
        particle(i).Position = max(particle(i).Position,VarMin);
        particle(i).Position = min(particle(i).Position,VarMax);
        
        % Evaluation
        particle(i).Cost = CostFunction(particle(i).Position,InputImage);
        
        % Update Personal Best
        if particle(i).Cost > particle(i).Best.Cost
            
            particle(i).Best.Position=particle(i).Position;
            particle(i).Best.Cost=particle(i).Cost;
            
            % Update Global Best
            if particle(i).Best.Cost > GlobalBest.Cost
                
                GlobalBest=particle(i).Best;
                
            end
            
        end
        
    end
    
    BestCost(it)=GlobalBest.Cost;
    
    disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it))]);
    
    
end

BestSol = GlobalBest;
disp(['The global best is ' num2str(BestSol.Position) ': Best Cost = ' num2str(BestSol.Cost)]);


%% Results

x=BestSol.Position;



end