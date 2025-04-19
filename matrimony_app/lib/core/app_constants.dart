// Column names for the 'users' table.
const String ID = 'id';
const String NAME = 'name';
const String EMAIL = 'email';
const String PASSWORD = 'password';
const String PHONE = 'phone';
const String GENDER = 'gender';
const String BIRTHDATE = 'birthdate';
const String AGE = 'age';
const String HEIGHT = 'height';
const String WEIGHT = 'weight';
const String HOBBIES = 'hobbies';
const String EDUCATION = 'education';
const String OCCUPATION = 'occupation';
const String EMPLOYED_IN = 'employed_in';
const String INCOME = 'income';
const String MARITAL_STATUS = 'marital_status';
const String MOTHER_TONGUE = 'mother_tongue';
const String RELIGION = 'religion';
const String COUNTRY = 'country';
const String STATE = 'state';
const String CITY = 'city';
const String ISFAVORITE = 'is_favorite';

List<String> hobbiesList = [
  'Travel 🌍',
  'Cooking 🍳',
  'Reading 📚',
  'Fitness 🏋️',
  'Music 🎵',
  'Movies 🎬',
  'Photography 📸',
  'Sports ⚽',
  'Art 🎨',
  'Nature 🌿',
  'Technology 💻',
  'Fashion 👗',
  'Gaming 🎮',
  'Hiking 🥾',
  'Dancing 💃',
  'Writing ✍️',
  'Meditation 🧘',
  'Poetry 📜',
  'Camping 🏕️',
  'Science 🔬',
  'Interior Design 🏡',
  'Fishing 🎣',
  'Running 🏃',
  'Cycling 🚴',
  'Motor Sports 🏎️'
];

const List<String> HEIGHT_OPTIONS = [
  "7'0 ft",
  "6'11 ft",
  "6'10 ft",
  "6'9 ft",
  "6'8 ft",
  "6'7 ft",
  "6'6 ft",
  "6'5 ft",
  "6'4 ft",
  "6'3 ft",
  "6'2 ft",
  "6'1 ft",
  "6'0 ft",
  "5'11 ft",
  "5'10 ft",
  "5'9 ft",
  "5'8 ft",
  "5'7 ft",
  "5'6 ft",
  "5'5 ft",
  "5'4 ft",
  "5'3 ft",
  "5'2 ft",
  "5'1 ft",
  "5'0 ft",
];

const List<String> EDUCATION_LIST = [
  'High School',
  'Associate Degree',
  'Bachelor\'s Degree',
  'Master\'s Degree',
  'Doctorate',
  'Other'
];

const List<String> OCCUPATION_LIST = [
  'Software Engineer',
  'Doctor',
  'Teacher',
  'Business Owner',
  'Artist',
  'Freelancer',
  'Other'
];

const List<String> EMPLOYEDIN_LIST = [
  'Government',
  'Private Sector',
  'Self-Employed',
  'Unemployed',
  'Other'
];

const List<String> INCOME_LIST = [
  'Less than \₹3,00,000',
  '\₹3,00,000 - \₹6,00,000',
  '\₹6,00,000 - \₹12,00,000',
  'Above \₹12,00,000',
];

// List of available countries.
const List<String> COUNTRY_LIST = [
  "USA",
  "Canada",
  "India",
];

// Map of states for each country.
const Map<String, List<String>> STATES_MAP = {
  "USA": ["California", "New York", "Texas"],
  "Canada": ["Ontario", "Quebec", "British Columbia"],
  "India": ["Gujarat", "Maharashtra", "Uttar Pradesh"],
};

// Map of cities for each state.
const Map<String, List<String>> CITIES_MAP = {
  "California": ["Los Angeles", "San Francisco", "San Diego"],
  "New York": ["New York City", "Buffalo", "Rochester"],
  "Texas": ["Houston", "Dallas", "Austin"],
  "Ontario": ["Toronto", "Ottawa", "Mississauga"],
  "Quebec": ["Montreal", "Quebec City", "Laval"],
  "British Columbia": ["Vancouver", "Victoria", "Kelowna"],
  "Maharashtra": ["Mumbai", "Pune", "Nagpur"],
  "Gujarat": ["Rajkot", "Ahmedabad", "Surat", "Vadodara"],
  "Uttar Pradesh": ["Ayodhya", "Prayagraj", "Mathura"],
};

/// List of available marital status options.
const List<String> MARITAL_STATUS_LIST = [
  'Never Married',
  'Married',
  'Divorced',
  'Widowed',
  'Separated',
];

/// List of available mother tongue options.
const List<String> MOTHER_TONGUE_LIST = [
  'Gujarati',
  'Hindi',
  'English',
  'Bengali',
  'Telugu',
  'Marathi',
  'Tamil',
  'Urdu',
  'Malayalam',
  'Kannada',
  'Odia',
  'Punjabi',
  'Assamese',
  'Maithili',
  'Other',
];

/// List of available religion options.
const List<String> RELIGION_LIST = [
  'Hinduism 🕉️',
  'Islam ☪️',
  'Christianity ✝️',
  'Buddhism ☸️',
  'Sikhism 🪯',
  'Jainism 🛕',
  'Judaism ✡️',
  'Shinto ⛩️',
  'Taoism ☯️',
  'Zoroastrianism 🔥',
  'Baháʼí Faith ⭐',
  'Confucianism 🎓',
  'Paganism 🍀',
  'Animism 🌿',
  'Rastafarianism 🇪🇹',
  'Druze 🌕',
  'Shamanism 🪄',
  'Cao Dai ☯️',
  'Tenrikyo 🙏',
  'Seicho-no-Ie 🌸',
  'Cheondoism ☀️',
  'Wicca 🔮',
  'Deism 🌞',
  'Agnosticism 🤔',
  'Atheism 🚫',
  'Spiritual but not religious 🛐',
  'Other 🏛️',
];
