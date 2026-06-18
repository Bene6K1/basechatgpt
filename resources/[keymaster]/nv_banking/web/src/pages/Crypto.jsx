import React, { useState, useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux'
import { updatePlayerCrypto, updatePlayerBalance, FormatMoney } from '../store/configSlice2'

function Crypto() {
    const dispatch = useDispatch();
    const { PlayerInformation } = useSelector(state => state.config);
    
    const [isExpanded, setIsExpanded] = useState(false);
    const [isLeftExpanded, setIsLeftExpanded] = useState(false);
    const [cryptoData, setCryptoData] = useState([]);
    const [userCryptos, setUserCryptos] = useState(PlayerInformation.CryptoHoldings || []);
    const [searchTerm, setSearchTerm] = useState('');
    const [selectedCrypto, setSelectedCrypto] = useState(null);
    const [buyAmount, setBuyAmount] = useState(1);
    const [sellAmount, setSellAmount] = useState('');
    const [hoveredCrypto, setHoveredCrypto] = useState(null);
    const [selectedSellCrypto, setSelectedSellCrypto] = useState(null);

    // Fetch crypto data from API
    useEffect(() => {
        fetchCryptoData();
        // Update every 30 seconds with CoinMarketCap API
        const interval = setInterval(fetchCryptoData, 30000);
        return () => clearInterval(interval);
    }, []);

    const fetchCryptoData = async () => {
        try {
            // Use CoinGecko API directly (no CORS issues, no API key needed)
            const cryptoIds = ['bitcoin', 'ethereum', 'binancecoin', 'cardano', 'solana', 'ripple', 'dogecoin', 'chainlink', 'litecoin', 'stellar'].join(',');
            
            // Add delay to prevent rate limiting
            await new Promise(resolve => setTimeout(resolve, 500));
            
            const response = await fetch(`https://api.coingecko.com/api/v3/simple/price?ids=${cryptoIds}&vs_currencies=usd&include_24hr_change=true&include_7d_change=true&include_30d_change=true`, {
                headers: {
                    'Accept': 'application/json',
                    'User-Agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36'
                }
            });
            
            if (!response.ok) {
                throw new Error(`HTTP error! status: ${response.status}`);
            }
            
            const data = await response.json();
            
            // Transform CoinGecko data to our format
            const formattedData = Object.entries(data).map(([id, info]) => ({
                id,
                symbol: getCryptoSymbol(id),
                name: getCryptoName(id),
                price: info.usd,
                change24h: info.usd_24h_change || 0,
                change7d: info.usd_7d_change || 0,
                change30d: info.usd_30d_change || 0,
                logo: getCryptoLogo(id)
            }));
            
            setCryptoData(formattedData);
        } catch (error) {
            console.error('Error fetching crypto data:', error);
            
            // Use static fallback data when API fails
            setCryptoData([
                { id: 'bitcoin', symbol: 'BTC', name: 'Bitcoin', price: 45000, change24h: 2.5, change7d: 5.2, change30d: 12.8, logo: getCryptoLogo('bitcoin') },
                { id: 'ethereum', symbol: 'ETH', name: 'Ethereum', price: 3200, change24h: -1.2, change7d: 3.1, change30d: -2.5, logo: getCryptoLogo('ethereum') },
                { id: 'binancecoin', symbol: 'BNB', name: 'BNB', price: 320, change24h: 1.8, change7d: 4.7, change30d: 8.9, logo: getCryptoLogo('binancecoin') },
                { id: 'cardano', symbol: 'ADA', name: 'Cardano', price: 1.2, change24h: 5.8, change7d: 12.3, change30d: 25.6, logo: getCryptoLogo('cardano') },
                { id: 'solana', symbol: 'SOL', name: 'Solana', price: 95, change24h: 3.2, change7d: 8.9, change30d: 15.4, logo: getCryptoLogo('solana') },
                { id: 'ripple', symbol: 'XRP', name: 'XRP', price: 0.85, change24h: -0.5, change7d: 2.1, change30d: -1.8, logo: getCryptoLogo('ripple') },
                { id: 'dogecoin', symbol: 'DOGE', name: 'Dogecoin', price: 0.17, change24h: 8.5, change7d: 15.2, change30d: 45.7, logo: getCryptoLogo('dogecoin') },
                { id: 'chainlink', symbol: 'LINK', name: 'Chainlink', price: 18, change24h: 1.5, change7d: 6.8, change30d: 18.2, logo: getCryptoLogo('chainlink') },
                { id: 'litecoin', symbol: 'LTC', name: 'Litecoin', price: 75, change24h: 1.8, change7d: 4.2, change30d: 9.7, logo: getCryptoLogo('litecoin') },
                { id: 'stellar', symbol: 'XLM', name: 'Stellar', price: 0.12, change24h: 3.5, change7d: 7.8, change30d: 22.1, logo: getCryptoLogo('stellar') }
            ]);
        }
    };

    const getCryptoSymbol = (id) => {
        const symbols = { 
            bitcoin: 'BTC', ethereum: 'ETH', binancecoin: 'BNB', cardano: 'ADA', solana: 'SOL', 
            ripple: 'XRP', dogecoin: 'DOGE', chainlink: 'LINK', litecoin: 'LTC', stellar: 'XLM'
        };
        return symbols[id] || id.toUpperCase();
    };

    const getCryptoName = (id) => {
        const names = { 
            bitcoin: 'Bitcoin', ethereum: 'Ethereum', binancecoin: 'BNB', cardano: 'Cardano', 
            solana: 'Solana', ripple: 'XRP', dogecoin: 'Dogecoin', chainlink: 'Chainlink',
            litecoin: 'Litecoin', stellar: 'Stellar'
        };
        return names[id] || id;
    };

    const getCryptoLogo = (id) => {
        const logos = { 
            bitcoin: './bank/crypto/logos/bitcoin.png',
            ethereum: './bank/crypto/logos/ethereum.png',
            binancecoin: './bank/crypto/logos/bnb.png',
            cardano: './bank/crypto/logos/cardano.png',
            solana: './bank/crypto/logos/solana.png',
            ripple: './bank/crypto/logos/ripple.png',
            dogecoin: './bank/crypto/logos/dogecoin.png',
            chainlink: './bank/crypto/logos/chainlink.png',
            litecoin: './bank/crypto/logos/litecoin.png',
            stellar: './bank/crypto/logos/stellar.png',
        };
        return logos[id] || './bank/crypto/logos/default.png';
    };

    const handleBuyClick = (e, crypto) => {
        e.stopPropagation();
        setSelectedCrypto(crypto);
        setIsExpanded(true);
    };

    const handleItemClick = () => {
        if (isExpanded) {
            setIsExpanded(false);
            setSelectedCrypto(null);
        }
    };

    const handleLeftItemClick = (crypto) => {
        if (selectedSellCrypto?.symbol === crypto.symbol) {
            setIsLeftExpanded(false);
            setSelectedSellCrypto(null);
        } else {
            setIsLeftExpanded(true);
            setSelectedSellCrypto(crypto);
        }
    };

    const handleBuyCrypto = () => {
        if (!selectedCrypto || buyAmount <= 0) return;
        
        const totalCost = selectedCrypto.price * buyAmount;
        if (PlayerInformation.Balance < totalCost) {
            // Show error message - insufficient funds
            return;
        }

        // Update player balance
        dispatch(updatePlayerBalance(PlayerInformation.Balance - totalCost));

        // Update crypto holdings
        const existingHolding = userCryptos.find(c => c.symbol === selectedCrypto.symbol);
        let updatedCryptos;
        
        if (existingHolding) {
            updatedCryptos = userCryptos.map(c => 
                c.symbol === selectedCrypto.symbol 
                    ? { ...c, amount: c.amount + buyAmount, totalSpent: c.totalSpent + totalCost }
                    : c
            );
        } else {
            updatedCryptos = [...userCryptos, {
                symbol: selectedCrypto.symbol,
                name: selectedCrypto.name,
                amount: buyAmount,
                totalSpent: totalCost,
                buyPrice: selectedCrypto.price
            }];
        }

        dispatch(updatePlayerCrypto(updatedCryptos));
        setUserCryptos(updatedCryptos);
        setIsExpanded(false);
        setSelectedCrypto(null);
        setBuyAmount(0.1);
    };

    const handleSellCrypto = (crypto) => {
        if (!sellAmount || sellAmount <= 0 || sellAmount > crypto.amount) return;

        const currentPrice = cryptoData.find(c => c.symbol === crypto.symbol)?.price || crypto.buyPrice;
        const totalValue = currentPrice * sellAmount;

        // Update player balance
        dispatch(updatePlayerBalance(PlayerInformation.Balance + totalValue));

        // Update crypto holdings
        const updatedCryptos = userCryptos.map(c => 
            c.symbol === crypto.symbol 
                ? { ...c, amount: c.amount - sellAmount }
                : c
        ).filter(c => c.amount > 0); // Remove if amount becomes 0

        dispatch(updatePlayerCrypto(updatedCryptos));
        setUserCryptos(updatedCryptos);
        setSellAmount('');
        setIsLeftExpanded(false);
        setSelectedSellCrypto(null);
    };

    const calculateTotalCryptoValue = () => {
        return userCryptos.reduce((total, crypto) => {
            const currentPrice = cryptoData.find(c => c.symbol === crypto.symbol)?.price || crypto.buyPrice;
            return total + (crypto.amount * currentPrice);
        }, 0);
    };

    const calculateTotalProfit = () => {
        return userCryptos.reduce((total, crypto) => {
            const currentPrice = cryptoData.find(c => c.symbol === crypto.symbol)?.price || crypto.buyPrice;
            const currentValue = crypto.amount * currentPrice;
            return total + (currentValue - crypto.totalSpent);
        }, 0);
    };

    const calculateTotalSpent = () => {
        return userCryptos.reduce((total, crypto) => total + crypto.totalSpent, 0);
    };

    // Format crypto amount to remove unnecessary trailing zeros
    const formatCryptoAmount = (amount) => {
        if (amount === 0) return '0';
        
        // Convert to string and remove trailing zeros after decimal
        const str = amount.toString();
        
        // If it's a whole number, return without decimal
        if (Number.isInteger(amount)) {
            return amount.toString();
        }
        
        // Remove trailing zeros after decimal point
        return str.replace(/\.?0+$/, '');
    };

    const filteredCryptos = cryptoData.filter(crypto => 
        crypto.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        crypto.symbol.toLowerCase().includes(searchTerm.toLowerCase())
    );

    const totalCryptoValue = calculateTotalCryptoValue();
    const totalProfit = calculateTotalProfit();
    const totalSpent = calculateTotalSpent();
    const profitPercentage = totalSpent > 0 ? (totalProfit / totalSpent) * 100 : 0;

    return (
        <div className='w-full h-full flex justify-between'>
            <div className='w-[32vw] h-full relative'>
                <span className="text-white text-[.8333vw] font-normal font-['Poppins'] left-0 top-0 absolute">Total Balance</span>
                <div className="flex flex-wrap items-center left-0 top-[1.5vw] absolute">
                    <span className="text-white text-[2.3vw] font-medium font-['Poppins']">${FormatMoney(totalCryptoValue)}</span>
                    <div className={`px-[.7vw] h-[2.0833vw] flex flex-wrap items-center justify-center shadow-[0vw_0vw_7.2005vw_0vw_rgba(46,190,123,0.60)] border-[.0521vw] rounded-[.3125vw] ml-[.6vw] ${profitPercentage >= 0 ? 'bg-[#2EBE7B3B] border-[#2EBE7B3B]' : 'bg-[#FF38683B] border-[#FF38683B]'}`}>
                        <span className={`text-[.8333vw] font-semibold font-['Poppins'] ${profitPercentage >= 0 ? 'text-[#2EBE7B]' : 'text-[#ff0000]'}`}>
                            {profitPercentage >= 0 ? '+' : ''}{profitPercentage.toFixed(1)}%
                        </span>
                        <svg className={`w-[.5208vw] h-[.5208vw] ml-[.3vw] ${profitPercentage < 0 ? 'rotate-180' : ''}`} width="10" height="10" viewBox="0 0 10 10" fill="none">
                            <path d="M1.10706 9.2627L8.77088 1.59888M8.77088 1.59888V6.21564M8.77088 1.59888H4.20029" stroke={profitPercentage >= 0 ? "#2EBE7B" : "#FF3868"} strokeWidth="1.32963" strokeLinecap="round" strokeLinejoin="round"/>
                        </svg>
                    </div>
                </div>
                <span className="text-white/75 text-[.7vw] font-normal font-['Poppins'] left-0 top-[4.6vw] absolute">
                    Spent: ${FormatMoney(hoveredCrypto ? 
                        userCryptos.find(c => c.symbol === hoveredCrypto.symbol)?.totalSpent || 0 
                        : totalSpent
                    )}
                </span>
                
                {/* Time period stats - shows when hovering over crypto */}
                <div className='h-[2.2088vw] flex flex-wrap left-0 top-[6.9vw] absolute'>
                    <div className='pr-[1vw] h-full flex flex-col items-start border-r-[.0521vw] border-r-white/40'>
                        <span className="text-white/40 text-[.6474vw] font-medium font-['Poppins']">Today</span>
                        <div className='flex flex-wrap mt-[.2vw]'>
                            {hoveredCrypto ? (
                                <>
                                    <span className={`text-[.6093vw] font-medium font-['Poppins'] ${hoveredCrypto.change24h >= 0 ? 'text-[#2EBE7B]' : 'text-[#ff0000]'}`}>
                                        {hoveredCrypto.change24h >= 0 ? '+' : ''}{hoveredCrypto.change24h.toFixed(1)}%
                                    </span>
                                    <svg className={`w-[.5208vw] h-[.5208vw] ml-[.3vw] mt-[.15vw] ${hoveredCrypto.change24h < 0 ? 'rotate-180' : ''}`} width="10" height="10" viewBox="0 0 10 10" fill="none">
                                        <path d="M1.30713 8.91425L8.89325 1.32812M8.89325 1.32812V5.89808M8.89325 1.32812H4.369" stroke={hoveredCrypto.change24h >= 0 ? "#2EBE7B" : "#FF3868"} strokeWidth="1.46239" strokeLinecap="round" strokeLinejoin="round"/>
                                    </svg>
                                </>
                            ) : (
                                <span className="text-white/40 text-[.6093vw] font-medium font-['Poppins']">-</span>
                            )}
                        </div>
                    </div>
                    <div className='px-[1vw] h-full flex flex-col items-center border-r-[.0521vw] border-r-white/40'>
                        <span className="text-white/40 text-[.6474vw] font-medium font-['Poppins']">7 Days</span>
                        <div className='flex flex-wrap mt-[.2vw]'>
                            {hoveredCrypto ? (
                                <>
                                    <span className={`text-[.6093vw] font-medium font-['Poppins'] ${hoveredCrypto.change7d >= 0 ? 'text-[#2EBE7B]' : 'text-red-500'}`}>
                                        {hoveredCrypto.change7d >= 0 ? '+' : ''}{hoveredCrypto.change7d.toFixed(1)}%
                                    </span>
                                    <svg className={`w-[.5208vw] h-[.5208vw] ml-[.3vw] mt-[.15vw] ${hoveredCrypto.change7d < 0 ? 'rotate-180' : ''}`} width="10" height="10" viewBox="0 0 10 10" fill="none">
                                        <path d="M1.30713 8.91425L8.89325 1.32812M8.89325 1.32812V5.89808M8.89325 1.32812H4.369" stroke={hoveredCrypto.change7d >= 0 ? "#2EBE7B" : "#FF3868"} strokeWidth="1.46239" strokeLinecap="round" strokeLinejoin="round"/>
                                    </svg>
                                </>
                            ) : (
                                <span className="text-white/40 text-[.6093vw] font-medium font-['Poppins']">-</span>
                            )}
                        </div>
                    </div>
                    <div className='px-[1vw] h-full flex flex-col items-center'>
                        <span className="text-white/40 text-[.6474vw] font-medium font-['Poppins']">30 Days</span>
                        <div className='flex flex-wrap mt-[.2vw]'>
                            {hoveredCrypto ? (
                                <>
                                    <span className={`text-[.6093vw] font-medium font-['Poppins'] ${hoveredCrypto.change30d >= 0 ? 'text-[#2EBE7B]' : 'text-red-500'}`}>
                                        {hoveredCrypto.change30d >= 0 ? '+' : ''}{hoveredCrypto.change30d.toFixed(1)}%
                                    </span>
                                    <svg className={`w-[.5208vw] h-[.5208vw] ml-[.3vw] mt-[.15vw] ${hoveredCrypto.change30d < 0 ? 'rotate-180' : ''}`} width="10" height="10" viewBox="0 0 10 10" fill="none">
                                        <path d="M1.30713 8.91425L8.89325 1.32812M8.89325 1.32812V5.89808M8.89325 1.32812H4.369" stroke={hoveredCrypto.change30d >= 0 ? "#2EBE7B" : "#FF3868"} strokeWidth="1.46239" strokeLinecap="round" strokeLinejoin="round"/>
                                    </svg>
                                </>
                            ) : (
                                <span className="text-white/40 text-[.6093vw] font-medium font-['Poppins']">-</span>
                            )}
                        </div>
                    </div>
                </div>

                {/* User's crypto holdings */}
                <div className='w-[29.0625vw] h-[77%] block left-0 bottom-0 absolute'>
                    {userCryptos.map((crypto, index) => {
                        const currentPrice = cryptoData.find(c => c.symbol === crypto.symbol)?.price || crypto.buyPrice;
                        const currentValue = crypto.amount * currentPrice;
                        const profit = currentValue - crypto.totalSpent;
                        const profitPercentage = crypto.totalSpent > 0 ? (profit / crypto.totalSpent) * 100 : 0;
                        
                        return (
                            <div key={crypto.symbol} className={`w-full bg-[#FFFFFF0D] flex justify-center relative mb-[.5vw] ${isLeftExpanded && selectedSellCrypto?.symbol === crypto.symbol ? 'h-[11.0938vw]' : 'h-[4.5271vw]'}`}>
                                <div className='w-full h-[4.5271vw] flex items-center relative'
                                     onMouseEnter={() => setHoveredCrypto(cryptoData.find(c => c.symbol === crypto.symbol))}
                                     onMouseLeave={() => setHoveredCrypto(null)}>
                                    <div className='flex flex-wrap items-center left-[1vw] absolute'>
                                        <div className='flex flex-col'>
                                            <span className="text-white text-[.9617vw] font-semibold font-['Poppins']">{crypto.symbol}</span>
                                            <span className="text-[#FFFFFF80] text-[.8243vw] font-normal font-['Poppins']">{crypto.name}</span>
                                        </div>
                                        <svg className='w-[1.7188vw] h-[1.7188vw] ml-[1.3vw]' style={{ transform: profitPercentage < 0 ? 'rotate(0deg)' : 'rotate(-180deg)' }} width="33" height="33" viewBox="0 0 33 33" fill="none">
                                            <circle cx="16.7469" cy="16.3358" r="15.1678" fill={profitPercentage >= 0 ? "#06D6A0" : "#FF3868"} fillOpacity="0.11" stroke={profitPercentage >= 0 ? "#06D6A0" : "#FF3868"} strokeWidth="1.31894"/>
                                            <path fillRule="evenodd" clipRule="evenodd" d="M16.3068 8.42151C15.77 8.42151 15.3348 8.85666 15.3348 9.39344V13.7676H12.0965C10.6002 13.7676 9.66491 15.3875 10.4131 16.6834L14.6217 23.9729C15.3699 25.2688 17.2404 25.2688 17.9886 23.9729L22.1972 16.6834C22.9454 15.3875 22.0101 13.7676 20.5137 13.7676H17.2787V9.39344C17.2787 8.85666 16.8436 8.42151 16.3068 8.42151Z" fill={profitPercentage >= 0 ? "#06D6A0" : "#FF3868"} fillOpacity="0.28"/>
                                        </svg>
                                    </div>
                                    <div className='flex flex-col left-[10vw] absolute gap-y-[.1vw]'>
                                        <span className={`text-[.88vw] font-semibold font-['Poppins'] ${profit >= 0 ? 'text-[#06D6A0]' : 'text-[#FF3868]'}`}>
                                            {profit >= 0 ? '+' : ''}${FormatMoney(profit)}
                                        </span>
                                        <span className={`text-[.7vw] font-normal font-['Poppins'] ${profit >= 0 ? 'text-[#06D6A080]' : 'text-[#FF386880]'}`}>
                                            {profit >= 0 ? '+' : ''}{profitPercentage.toFixed(2)}%
                                        </span>
                                    </div>
                                    <div className='flex flex-col right-[5vw] absolute gap-y-[.1vw]'>
                                        <span className="text-end text-[#FFFFFF] text-[.88vw] font-semibold font-['Poppins']">{formatCryptoAmount(crypto.amount)}</span>
                                        <span className="text-end text-[#FFFFFF80] text-[.7vw] font-normal font-['Poppins']">${FormatMoney(currentValue)}</span>
                                    </div>
                                    <div className='flex flex-col items-center right-[1vw] absolute'>
                                        <div className={`w-[2.2917vw] h-[2.2917vw] flex items-center justify-center rounded-full cursor-pointer ${isLeftExpanded && selectedSellCrypto?.symbol === crypto.symbol ? 'bg-[#0E785F]' : 'bg-[#FFFFFF1A]'}`} 
                                             onClick={() => handleLeftItemClick(crypto)}>
                                            <svg className='w-[.9375vw] h-[.9375vw]' width="18" height="18" viewBox="0 0 18 18" fill="none">
                                                <path d="M17.3992 11.019L11.0189 17.3992C10.8405 17.5777 10.6397 17.7116 10.4166 17.8008C10.1935 17.89 9.97042 17.9346 9.74733 17.9346C9.52425 17.9346 9.30116 17.89 9.07807 17.8008C8.85499 17.7116 8.65421 17.5777 8.47574 17.3992L0.600805 9.52431C0.437209 9.36071 0.310794 9.17124 0.221559 8.95588C0.132325 8.74053 0.0877075 8.51358 0.0877075 8.27503V1.87246C0.0877075 1.38167 0.262607 0.961671 0.612406 0.612467C0.962205 0.263263 1.3822 0.0883635 1.8724 0.0877686H8.27496C8.51292 0.0877686 8.74344 0.136253 8.96653 0.233221C9.18962 0.330189 9.38296 0.460173 9.54655 0.623175L17.3992 8.49811C17.5777 8.67658 17.7079 8.87736 17.79 9.10044C17.8721 9.32353 17.9129 9.54662 17.9123 9.7697C17.9117 9.99279 17.8709 10.2123 17.79 10.4283C17.7091 10.6442 17.5788 10.8411 17.3992 11.019ZM4.10326 5.44183C4.47507 5.44183 4.79125 5.31185 5.05182 5.05188C5.31238 4.79191 5.44237 4.47572 5.44177 4.10332C5.44118 3.73091 5.31119 3.41502 5.05182 3.15565C4.79244 2.89627 4.47626 2.76599 4.10326 2.7648C3.73026 2.76361 3.41437 2.89389 3.15559 3.15565C2.89681 3.4174 2.76652 3.73329 2.76474 4.10332C2.76295 4.47334 2.89324 4.78953 3.15559 5.05188C3.41794 5.31423 3.73383 5.44421 4.10326 5.44183Z" fill="white"/>
                                            </svg>
                                        </div>
                                        <span className="text-white/60 text-[.5099vw] font-medium font-['Poppins'] mt-[.3vw]">SELL</span>
                                    </div>
                                </div>
                                
                                {/* Sell interface - for selected crypto when expanded */}
                                {isLeftExpanded && selectedSellCrypto?.symbol === crypto.symbol && (
                                    <>
                                        <input 
                                            type='number' 
                                            className='w-[96%] h-[2.0833vw] bg-[#1F252D] rounded-[.1918vw] top-[4.5vw] absolute text-white text-[.7vw] font-normal font-["Poppins"] px-[.5vw] outline-none' 
                                            placeholder={formatCryptoAmount(selectedSellCrypto.amount)}
                                            value={sellAmount}
                                            onChange={(e) => setSellAmount(e.target.value)}
                                            max={selectedSellCrypto.amount}
                                        />
                                        <div className='w-[96%] h-[1vw] flex items-center justify-between top-[7vw] absolute'>
                                            <div className='w-[46%] h-[5%] bg-[#FFFFFF1A]'></div>
                                            <div className='w-[3.5%] h-full flex items-center justify-center rounded-full bg-[#FFFFFF1A]'>
                                                <svg className='w-[.4688vw] h-[.4688vw] scale-[1.09]' width="9" height="8" viewBox="0 0 9 8" fill="none">
                                                    <path d="M1.12402 3.11035L6.17898 3.11035L4.30142 0.69229" stroke="white" strokeWidth="0.920724" strokeLinecap="round" strokeLinejoin="round"/>
                                                    <path d="M7.87604 4.71924L2.82108 4.71924L4.69864 7.1373" stroke="white" strokeWidth="0.920724" strokeLinecap="round" strokeLinejoin="round"/>
                                                </svg>
                                            </div>
                                            <div className='w-[46%] h-[5%] bg-[#FFFFFF1A]'></div>
                                        </div>
                                        <div className='w-[96%] h-[2.0833vw] flex items-center bg-[#1F252D] rounded-[.1918vw] bottom-[.6vw] absolute'>
                                            <span className='text-white text-[.7vw] font-normal font-["Poppins"] ml-[.5vw]'>
                                                ${sellAmount ? FormatMoney(sellAmount * currentPrice) : '0.00'}
                                            </span>
                                            <div 
                                                className='px-[1vw] h-[1.4792vw] flex items-center justify-center bg-[#0E785F] rounded-[.2148vw] right-[.5vw] absolute cursor-pointer'
                                                onClick={() => handleSellCrypto(selectedSellCrypto)}
                                            >
                                                <span className='text-white text-[.65vw] font-normal font-["Poppins"]'>Confirm</span>
                                            </div>
                                        </div>
                                    </>
                                )}
                            </div>
                        );
                    })}
                </div>
            </div>
            
            <div className='w-[29.1667vw] h-full relative'>
                <div className='w-full h-[2.6492vw] flex items-center bg-[#12151A] top-0 absolute'>
                    <span className="text-white text-[.9692vw] font-medium font-['Poppins'] ml-[1vw]">Crypto Market</span>
                </div>
                <div className='w-full h-[2.6492vw] flex items-center bg-[#12151A] top-[3.05vw] absolute'>
                    <img src='./bank/crypto/search-icon.png' className='w-[.9767vw] h-[.9767vw] ml-[1vw]' />
                    <input 
                        type='text' 
                        className='w-[87%] h-[80%] text-white text-[.8333vw] font-normal font-["Poppins"] outline-none ml-[1vw] placeholder:text-[#B5B5B5]' 
                        placeholder='Search' 
                        value={searchTerm}
                        onChange={(e) => setSearchTerm(e.target.value)}
                    />
                </div>
                <div className='w-full h-[86.8%] block overflow-y-auto bottom-0 absolute'>
                    {filteredCryptos.map((crypto) => (
                        <div key={crypto.id} className={`w-full flex items-center justify-center bg-[#FFFFFF0D] mb-[.5vw] relative ${isExpanded && selectedCrypto?.id === crypto.id ? 'h-[12.3438vw]' : 'h-[4.5596vw]'}`}>
                            <div className='w-full h-[4.5596vw] flex items-center left-0 top-0 absolute cursor-pointer' onClick={handleItemClick}>
                                <div className='w-[2.7246vw] h-[2.7246vw] flex items-center justify-center ml-[1vw] rounded-full bg-[#1F252D]'>
                                    <img src={crypto.logo} alt={crypto.name} className='w-full h-full rounded-full' />
                                </div>
                                <div className='h-[2.3vw] flex flex-col justify-between left-[4.5vw] absolute mb-[.1vw]'>
                                    <div className='flex flex-wrap'>
                                        <span className="text-white text-[1vw] font-['Poppins'] leading-snug">{crypto.symbol}</span>
                                        <div className='flex flex-wrap ml-[.5vw]'>
                                            <div className='flex items-center justify-center px-[1vw] py-[.2vw] bg-[#F0408633]'>
                                                <span className="flex flex-wrap items-center text-[#F04086] text-[.5297vw] font-medium font-['Poppins']">
                                                    {crypto.change24h >= 0 ? '+' : ''}{crypto.change24h.toFixed(1)}%
                                                    <svg className='w-[.3646vw] h-[.3646vw] ml-[.2vw]' width="7" height="7" viewBox="0 0 7 7" fill="none">
                                                        <path d="M1.2236 5.57452L6.24783 0.550293M6.24783 0.550293V3.57693M6.24783 0.550293H3.25145" stroke="#F04086" strokeWidth="0.871673" strokeLinecap="round" strokeLinejoin="round"/>
                                                    </svg>
                                                </span>
                                            </div>
                                        </div>
                                    </div>
                                    <span className="text-white/75 text-[.8vw] font-['Poppins'] leading-none">{crypto.name}</span>
                                </div>
                                {!isExpanded && selectedCrypto?.id != crypto.id && (
                                    <div className='flex items-center justify-center px-[1.4vw] py-[.5vw] bg-[#2D323A] right-[1vw] absolute cursor-pointer' onClick={(e) => handleBuyClick(e, crypto)}>
                                        <span className="text-white text-[.6545vw] font-semibold font-['Poppins'] leading-none">BUY</span>
                                    </div>
                                )}
                            </div>
                            
                            {/* Buy interface */}
                            {isExpanded && selectedCrypto?.id === crypto.id && (
                                <>
                                    <div className='w-[27vw] h-[2.8646vw] flex items-center justify-between bg-[#34343447] rounded-[.4167vw] top-[4.4vw] absolute z-[10]'>
                                        <span 
                                            className="text-white text-[1.2259vw] font-normal font-['Poppins'] ml-[1vw] cursor-pointer"
                                            onClick={() => setBuyAmount(Math.max(0, buyAmount - 0.1))}
                                        >
                                            -
                                        </span>
                                        <input 
                                            type='number' 
                                            step="0.01"
                                            min="0"
                                            className='w-[60%] text-center text-white text-[.9375vw] font-normal font-["Poppins"] outline-none bg-transparent' 
                                            value={buyAmount}
                                            onChange={(e) => {
                                                const value = parseFloat(e.target.value);
                                                setBuyAmount(isNaN(value) ? 0 : Math.max(0, value));
                                            }}
                                        />
                                        <span 
                                            className="text-white text-[1.2259vw] font-normal font-['Poppins'] mr-[1vw] cursor-pointer"
                                            onClick={() => setBuyAmount(buyAmount + 0.1)}
                                        >
                                            +
                                        </span>
                                    </div>
                                    <div className='w-[27vw] h-[3.3333vw] flex items-center justify-between bg-[#34343447] rounded-[.4167vw] bottom-[1vw] absolute z-[10]'>
                                        <span className="text-white text-[.9vw] font-normal font-['Poppins'] ml-[1vw]">
                                            ${Math.round(buyAmount * crypto.price)}$
                                        </span>
                                        <div 
                                            className='w-[6vw] h-[2.5vw] flex items-center justify-center bg-[#F04086] rounded-[.4167vw] cursor-pointer mr-[.5vw]'
                                            onClick={handleBuyCrypto}
                                        >
                                            <span className="text-white text-[.8333vw] font-medium font-['Poppins']">Buy</span>
                                        </div>
                                    </div>
                                </>
                            )}
                        </div>
                    ))}
                </div>
            </div>
        </div>
    )
}

export default Crypto