<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>User List</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 min-h-screen font-sans">
    <div class="max-w-2xl mx-auto mt-10 bg-white shadow-md rounded-lg p-6">
        <h1 class="text-2xl font-bold mb-4 text-gray-800">User List</h1>

        <form action="/store" method="POST" class="space-y-4 mb-6">
            @csrf
            <div>
                <input 
                    type="text" 
                    name="name" 
                    placeholder="Enter Name" 
                    required 
                    class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                >
            </div>
            <div>
                <input 
                    type="email" 
                    name="email" 
                    placeholder="Enter Email" 
                    required 
                    class="w-full p-2 border border-gray-300 rounded focus:outline-none focus:ring-2 focus:ring-blue-500"
                >
            </div>
            <button 
                type="submit" 
                class="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700"
            >
                Add User
            </button>
        </form>

        <h2 class="text-xl font-semibold mb-3 text-gray-700">Stored Users</h2>
        <ul class="space-y-2">
            @foreach($users as $user)
                <li class="p-3 bg-gray-50 border border-gray-200 rounded">
                    <strong>{{ $user->name }}</strong> – {{ $user->email }}
                </li>
            @endforeach
        </ul>
    </div>
</body>
</html>
